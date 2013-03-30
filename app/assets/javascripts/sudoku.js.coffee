$ ->
  $('#solve-sudoku').click ->
    grids = []
    $('#origin-sudoku-grids tr').each (index, tr) ->
      grids[index] = ($(item).text() for item in $(tr).children('td'))

    check_grids(grids)

    $.ajax '/sudoku/solution',
      type: 'POST'
      data: { 'grids': grids }
      success: (data, textStatus, jqXHR) ->
        if data
          render(data)
        else
          alert('These is no solution')

  $('#origin-sudoku-grids tr td').click ->
    $('#origin-sudoku-grids tr td.focus').removeClass('focus')
    $(@).addClass('focus')

  $('body').on 'keydown', (e) ->
    if e.keyCode >= 48 && e.keyCode <= 57
      if ($('#origin-sudoku-grids tr td.focus').length > 0)
        $('#origin-sudoku-grids tr td.focus').text(String.fromCharCode(e.keyCode))
    else if e.keyCode == 8
      if ($('#origin-sudoku-grids tr td.focus').length > 0)
        $('#origin-sudoku-grids tr td.focus').text("")
      e.preventDefault()

  render = (grids) ->
    $('#solved-sudoku-grids tr').each (i, tr) ->
      $(tr).children('td').each (j, cell) ->
        $(cell).text(grids[i][j])

  check_grids = (grids) ->
    $('#origin-sudoku-grids tr td').removeClass('conflict')

    for i in [0..8]
      for j in [0..8]
        number = grids[i][j]
        if number
          conclict = check_row(i, j, number, grids) ||
            check_column(i, j, number, grids) ||
            check_block(i, j, number, grids)
        if conclict
          render_conflict_grid(i, j)
          return false

  check_row = (row, col, number, grids) ->
    for j in [0..8]
      if grids[row][j] == number && j != col
        render_conflict_grid(row, j)
        return true
    return false

  check_column = (row, col, number, grids) ->
    for i in [0..8]
      if grids[i][col] == number && i != row
        render_conflict_grid(i, col)
        return true
    return false

  check_block = (row, col, number, grids) ->
    block_top = Math.floor(row/3) * 3
    block_left = Math.floor(col/3) * 3

    for i in [block_top..block_top + 2]
      for j in [block_left..block_left + 2]
        if grids[i][j] == number && i != row && j!= col
          render_conflict_grid(i, j)
          return true
    return false

  render_conflict_grid = (i, j) ->
    td_order = (i * 9) + j
    $($('#origin-sudoku-grids tr td')[td_order]).addClass('conflict')


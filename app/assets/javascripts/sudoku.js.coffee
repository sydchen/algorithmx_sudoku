$ ->
  $('#solve-sudoku').click ->
    grids = []
    $('#origin-sudoku-grids tr').each (index, tr) ->
      grids[index] = ($(item).text() for item in $(tr).children('td'))
      
    console.log(grids)

    $.ajax '/sudoku/solution',
      type: 'POST'
      data: { 'grids': grids }
      success: (data, textStatus, jqXHR) ->
        render(data)

  render = (grids) ->
    $('#solved-sudoku-grids tr').each (i, tr) ->
      $(tr).children('td').each (j, element) ->
        $(element).text(grids[i][j])

  $('#origin-sudoku-grids tr td').click ->
    $('#origin-sudoku-grids tr td.focus').removeClass('focus')
    $(@).addClass('focus')

  $('body').keypress (e) ->
    if e.keyCode >= 48 && e.keyCode <= 57
      if ($('#origin-sudoku-grids tr td.focus').length > 0)
        $('#origin-sudoku-grids tr td.focus').text(String.fromCharCode(e.keyCode)) 


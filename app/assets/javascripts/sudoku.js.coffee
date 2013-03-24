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


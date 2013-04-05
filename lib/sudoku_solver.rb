module SudokuSolver
  include ExactCover

  def prepare(constrains, y)
    x = {}
    y.values.flatten(1).uniq.sort.each {|c| x[c] = [] }

    y.each do |k, v|
      v.each do |c|
        x[c] << k
      end
    end
    x
  end

  def solve_exact_cover
    n = 0
    x = y = {}

    File.open('sample_data.txt') do |f|
      n = f.readline
      input = []
      f.each_line {|line| input << line.strip.split(',').map(&:to_i) }

      y = Hash[(1..input.length).map() {|i| "row#{i}"}.zip(input)]
      x = prepare(input, y)
    end

    solution = []
    if solve(x, y, solution)
      for s in solution do
        print s, y[s], "\n"
      end
    end
  end

  def solve_sudoku(grids = {})
    sudoku_table = grids.map do |row|
      row[1].map(&:to_i)
    end

    if sudoku_table.empty?
      File.open('sudoku_input.txt') do |f|
        f.each_line {|line| sudoku_table << line.strip.split(',').map(&:to_i) }
      end
    end

    size = 9
    constrains = Array(0..size-1).product(Array(0..size-1)).map { |p| ['rc', p] } +
      Array(0..size-1).product(Array(1..size)).map { |p| ['rn', p] } +
      Array(0..size-1).product(Array(1..size)).map { |p| ['cn', p] } +
      Array(0..size-1).product(Array(1..size)).map { |p| ['bn', p] }

    y = {}
    Array(0..size-1).product(Array(0..size-1), Array(1..size)).each do |p|
      r, c, n = *p
      b = (r / 3).floor * 3 + (c / 3).floor # Box number
      y[p] = [] << ["rc", [r, c]] << ["rn", [r, n]] << ["cn", [c, n]] << ["bn", [b, n]]
    end

    x = prepare(constrains, y)

    sudoku_table.each_with_index do |row, i|
      row.each_with_index do |c, j|
        select(x, y, [i, j, c]) if c > 0
      end
    end

    solutions = []
    solve(x, y, []) do |solution|
      for r, c, n in solution do
        sudoku_table[r][c] = n
      end
      solutions << sudoku_table
    end
    solutions[0] if solutions.length
  end
end


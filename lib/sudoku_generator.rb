


def random_grids
  puzzle = [0] * 81
  a = (1..9).to_a.sample(9)
  b = (1..9).to_a.sample(9)
  c = (1..9).to_a.sample(9)

# Completely fill in the upper-left 3x3 section.
  puzzle[0..2] = a[0..2]
  puzzle[9..11] = a[3..5]
  puzzle[18..20] = a[6..8]

# Completely fill in the center 3x3 section.
  puzzle[30..32] = b[0..2]
  puzzle[39..41] = b[3..5]
  puzzle[48..50] = b[6..8]

# Completely fill in the lower-right 3x3 section.
  puzzle[60..62] = c[0..2]
  puzzle[69..71] = c[3..5]
  puzzle[78..80] = c[6..8]

  puzzle
end

def generate_sudoko_grids
  while(true)
    puzzle = random_grids
    possible_puzzle = puzzle.each_slice(9).to_a

    s =  Hash[(0..possible_puzzle.length - 1).zip(possible_puzzle)]
    Rails.logger.debug s
    solution_puzzle = solve_sudoku(s)
    if solution_puzzle
      solution_puzzle.flatten!
      (0..80).to_a.sample(56).each { |index| solution_puzzle[index] = 0 }
      return solution_puzzle.each_slice(9).to_a
    end
  end
end

require 'sudoku_generator'
class SudokuController < ApplicationController
  include SudokuSolver
  def index
    @random = generate_sudoko_grids
  end

  def solution
    respond_to do |format|
      format.json do
        solution_grids = solve_sudoku(params[:grids])
        render :json => solution_grids
      end
    end
  end
end

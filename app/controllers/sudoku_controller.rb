class SudokuController < ApplicationController
  include SudokuSolver
  def index

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

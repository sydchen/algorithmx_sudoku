class SudokuController < ApplicationController
  include SudokuSolver
  def index

  end

  def solution
    respond_to do |format|
      format.json do
        solution_grids = solve_sudoku(params[:grids])
        if solution_grids
          render :json => solution_grids
        else
          render :nothing => true, :status => 200, :content_type => 'text/html' 
        end  
      end
    end
  end
end

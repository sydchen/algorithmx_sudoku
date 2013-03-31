class ErrorsController < ApplicationController
  def not_found
    render :text => 'not found', :status => 404
  end

end

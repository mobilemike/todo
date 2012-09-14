class ReassignmentsController < ApplicationController
  def create
    if params[:task_id]      
      Task.find(params[:task_id]).move_forward
    else
      List.find(params[:list_id]).move_forward
    end

    redirect_to lists_path
  end
end
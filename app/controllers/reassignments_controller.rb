class ReassignmentsController < ApplicationController
  def create
    if params[:task_id]      
      tasks = Task.find(params[:task_id])
    else
      tasks = List.find(params[:list_id])
    end

    tasks.move_forward
    redirect_to tasks_path
  end
end
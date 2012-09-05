class ReassignmentsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    task.move_forward
    redirect_to tasks_path
  end
end

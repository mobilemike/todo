class CompletionsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    task.update_attributes completed: true
    redirect_to lists_path
  end

  def destroy
    task = Task.find(params[:task_id])
    task.update_attributes completed: false
    redirect_to lists_path
  end
end

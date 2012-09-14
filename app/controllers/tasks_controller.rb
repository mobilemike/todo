class TasksController < ApplicationController
  before_filter :load_lists, only: [:create, :update]

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @tasks = Task.build_one_or_more_tasks(params[:task])

    if @tasks.all?(&:valid?)
      @tasks.each(&:save)

      case @tasks.size
      when 1
        notice = 'Task was successfully created.'
      else
        notice = 'Multiple tasks were successfully created.'
      end

      redirect_to lists_url, notice: notice
    else
      render 'lists/index'
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to lists_url, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end
end

class TasksController < ApplicationController

  before_filter :load_tasks, only: [:index, :create]

  def load_tasks
    @task = Task.new
    @past_list = List.find(:past)
    @yesterdays_list = List.find(:yesterday)
    @todays_list = List.find(:today)
    @tomorrows_list = List.find(:tomorrow)
  end

  # GET /tasks
  # GET /tasks.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @tasks = Task.build_one_or_more_tasks(params[:task])

    respond_to do |format|
      if @tasks.all?(&:valid?)
        @tasks.each(&:save)
        case @tasks.size
        when 1
          notice = 'Task was successfully created.'
        else
          notice = 'Multiple tasks were successfully created.'
        end
          format.html { redirect_to tasks_url, notice: notice }
          format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "index" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
end

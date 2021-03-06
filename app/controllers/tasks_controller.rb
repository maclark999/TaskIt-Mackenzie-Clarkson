class TasksController < ApplicationController
  before_action :authenticate
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  before_action :current_member
  layout 'internal'

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = @task.comments.all
    @comment = @task.comments.build
    @user = User.find_by_id(session[:user_id])
  end

  # GET /tasks/new
  def new
    @task = Task.new

  end

  # GET /tasks/1/edit
  def edit

  end

  # POST /tasks
  # POST /tasks.json
  def create

    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
      if @task.save
        redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
      else
        render :new
      end
    end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
      if @task.update(task_params)
        redirect_to project_tasks_path(@project), notice: 'Task was successfully updated'
      else
        render 'new'
      end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    if @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_date, :complete)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

end

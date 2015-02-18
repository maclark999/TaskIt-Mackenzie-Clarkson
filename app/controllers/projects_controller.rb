class ProjectsController < ApplicationController
before_action :set_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created'
    else
      render ('new')
    end
  end

  def destroy
    @project = Project.find(params[:id])
      if @project.destroy
        redirect_to projects_path, notice: 'Project was successfully destroyed'
      end
  end

  def edit

  end

  def update
    @project = Project.find(params[:id])
      if @project.update_attributes(project_params)
        redirect_to project_path, notice: 'Project was successfully updated'
      else render ('new')
      end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end


    def project_params
      params.require(:project).permit(:name)
    end
end

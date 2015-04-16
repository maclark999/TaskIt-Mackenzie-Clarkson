class ProjectsController < ApplicationController
before_action :authenticate
before_action :set_project, only: [:show, :edit, :update, :destroy]
layout 'internal'
  def index
    @projects = Project.all
    @user = User.find_by_id(session[:user_id])
  end

  def show
    @user = User.find_by_id(session[:user_id])
    @membership = Membership.where(user_id: @user.id, project_id: @project.id)
    @member_id = @project.memberships.map {|member| member.user_id }
    unless @member_id.include?(@user.id) || @user.admin?
      redirect_to projects_path, alert: 'You do not have access to that project'
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    user_id = session[:user_id]

    if @project.save
      @project.memberships.create(role: 1, user_id: user_id)
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created'
    else
      render ('new')
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @user = User.find_by_id(session[:user_id])
    @membership = Membership.where(user_id: @user.id, project_id: @project.id)

      if @user.admin? && @project.destroy || @membership[0].role == "owner" && @project.destroy
        redirect_to projects_path, notice: 'Project was successfully destroyed'
      else
        render :show, alert: 'You do not have access'
      end
  end

  def edit

  end

  def update
    @project = Project.find(params[:id])
      if @project.update_attributes(project_params)
        redirect_to project_path, notice: 'Project was successfully updated'
      else
        render ('new'), alert: 'You do not have access'
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

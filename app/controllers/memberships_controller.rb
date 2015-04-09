class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :current_member

  def index
    @memberships = @project.memberships
    @membership = Membership.new
    @user = User.find_by_id(session[:user_id])
  end

  def show
  end

  def create
    @user = User.find_by(params[:user_id])
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index, alert: 'Member creation unsuccessful'
    end
  end

  def edit
  end

  def update
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      render :index, alert: 'Member update failed'
    end
  end

  def destroy
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name}'s membership was successfully destroyed"
  end

private
  def set_membership
    @membership = Membership.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def current_member
    @project = Project.find_by_id(params[:project_id])
    @project.memberships.each do |member|
      if member.user_id != current_user.id
        redirect_to projects_path, alert: 'You do not have access to that project'
      end
    end
  end

end

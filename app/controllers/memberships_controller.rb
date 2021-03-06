class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :current_member
  layout 'internal'

  def index
    @memberships = @project.memberships
    @membership = Membership.new
    @user = User.find_by_id(session[:user_id])
    @current_membership = Membership.where(user_id: @user.id, project_id: @project.id)
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
    @memberships = @project.memberships
  if @membership.update(role: 1) && @memberships.where(role: 1).count == 1
    redirect_to :back, alert: "Projects much have at least one owner"
  elsif @memberships.where(role: 1).count > 1
      @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      render :index, alert: 'Member update failed'
    end
  end

  def destroy
    @membership.destroy
    if params[:from]=='own_membership'
      redirect_to projects_path, notice: "#{@membership.user.full_name} was successfully removed"
    else
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name}'s membership was successfully destroyed"
  end
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

end

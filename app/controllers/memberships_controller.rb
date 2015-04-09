class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = @project.memberships
    @membership = Membership.new
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

end

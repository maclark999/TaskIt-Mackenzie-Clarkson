class MembershipsController < ApplicationController
  before_action :set_project
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = @project.memberships
    @membership = @project.memberships.build
  end

  def show
  end

  def new
    @membership = @project.memberships.build
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index, alert: 'Membership creation unsuccessful'
    end
  end

  def edit
  end

  def update
  end

  def destroy
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

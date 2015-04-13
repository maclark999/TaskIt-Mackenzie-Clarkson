class UsersController < ApplicationController
before_action :authenticate
before_action :set_user, only: [:show, :edit, :update, :destroy]
layout 'internal'
  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created'
    else render ('new')
      end
    end


  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id || current_user.admin?
      render :file => '/public/404.html', :status => 404
    end
  end

  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        redirect_to users_path, notice: 'User was successfully updated'
      else render ('new')
      end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed'
    end
  end

private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

end

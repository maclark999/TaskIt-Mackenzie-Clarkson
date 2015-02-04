class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
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
      end
    end


  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to user_path
  end

  def destroy
    if @user.destroy
      redirect_to users_path
    end
  end

private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end

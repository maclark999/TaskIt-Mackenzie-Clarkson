class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to session[:return_to] || projects_path, notice: 'Welcome!'
    else
      flash.now[:invalid] = 'Email/password combination is invalid'
      render 'new'
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'You are now signed out.'
  end

end

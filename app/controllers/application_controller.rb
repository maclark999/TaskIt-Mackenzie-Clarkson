class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    if not current_user
      redirect_to signup_path, alert: 'You are not signed in!'
    end
  end

  def current_member
    @project = Project.find_by_id(params[:project_id])
    count = 0
    @project.memberships.each do |member|
      if member.user_id == current_user.id
          count += 1
        end
      end
      if count == 0
          redirect_to projects_path, alert: 'you do not have access'
      end
  end

    helper_method :current_member
    helper_method :current_user
end

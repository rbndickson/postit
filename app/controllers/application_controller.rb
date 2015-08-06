class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  # helper_method enables the methods to be used in views

  before_action :set_user_time_zone

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
	  access_denied unless logged_in?
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end

  def access_denied
    flash[:error] = "Sorry you do not have access"
    redirect_to root_path
  end

  def set_user_time_zone
    Time.zone = current_user.time_zone if logged_in?
  end
end

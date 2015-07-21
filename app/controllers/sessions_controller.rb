class SessionsController < ApplicationController

  def new # this is the login screen

  end

  def create # when you submit the login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are logged in"
      redirect_to root_path
    else
      flash[:error] = 'Login error, please try again.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out'
    redirect_to root_path
  end

end

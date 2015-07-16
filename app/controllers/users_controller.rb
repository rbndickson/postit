class UsersController < ApplicationController

  def create
    @user = User.new(post_params)
    if @user.save
      flash[:notice] = "New user created."
      redirect_to root_path
    else
      flash[:notice] = "Error"
      render :new
    end
  end

  private

  def post_params
    params.require(:user).permit(:username, :password)
  end

end

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(post_params)
    if @user.save
      flash[:notice] = "You have been registered and logged in."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = "Error"
      render :new
    end
  end

  def edit; end

  def update

  end

  def show
    @user = User.find(params[:id])
  end

  private

  def post_params
    params.require(:user).permit(:username, :password)
  end

end

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was created."
    else # in case of validation error
      flash[:notice] = "There was an error with your post."
      render 'new'
    end
  end

  def post_params
    params.require(:post).permit!
  end

  def edit

  end

  def update

  end
end

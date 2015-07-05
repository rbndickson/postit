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
      flash[:success] = "Your post was created."
      render 'show'
    else # in case of validation error
      flash[:notice] = "There was an error with your post."
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      flash[:success] = "Your post was updated."
      render 'show'
    else # in case of validation error
      flash[:notice] = "There was an error with your post."
      render 'edit'
    end
  end

  def post_params
    params.require(:post).permit!
  end
end

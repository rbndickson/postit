class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new # this is needed for the model backed form
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to post_path
    else
      render :edit
    end
  end

  def vote
	  @vote = Vote.create(votable: @post, creator: current_user, vote: params[:vote])

	  if @vote.valid?
	    flash[:notice] = 'Your vote has been counted'
	  else
	    flash[:error] = 'Error, you can only vote once'
    end
	  redirect_to :back # sends you back to previous url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, :user_id, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

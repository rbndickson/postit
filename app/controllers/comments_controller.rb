class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    # build adds @comment.post = @post as well as creating a new @comment object
    # with parameters by mass assignment
    if @comment.save
      flash[:notice] = 'Your comment has been saved'
      redirect_to post_path(@post)
    else
      @post.comments = @post.comments[0..-2]
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = 'Your vote has been counted'
    else
      flash[:error] = 'Error in voting'
    end
    redirect_to :back # sends you back to previous url
  end

end

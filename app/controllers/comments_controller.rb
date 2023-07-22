class CommentsController < ApplicationController
    def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to users_path notice: 'Comment was successfully created.'
    else
      flash.now[:error] = 'Failed to create comment.'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

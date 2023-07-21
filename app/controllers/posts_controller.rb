class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      # Handle successful post creation
      redirect_to @post
    else
      # Handle validation errors or other issues with post creation
      render :new
    end
  end

  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find_by(id: params[:user_id])
  end

  def show
    @post = Post.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Post not found'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end
end

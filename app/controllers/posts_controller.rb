class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(author_id: current_user.id))

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new
    end
  end

  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def likes
    @post = Post.find(params[:id])
    Like.create(author_id: current_user.id, post_id: @post.id)
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find_by(id: params[:id])
    redirect_to root_path, alert: 'Post not found' if @post.nil?
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

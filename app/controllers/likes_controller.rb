class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to post_path(@post), notice: 'Liked the post.'
    else
      redirect_to post_path(@post), alert: 'Failed to like the post.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)
    if @like.destroy
      redirect_to post_path(@post), notice: 'Unliked the post.'
    else
      redirect_to post_path(@post), alert: 'Failed to unlike the post.'
    end
  end
end

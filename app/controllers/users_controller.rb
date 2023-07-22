class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      @posts = @user.posts
      # Continue with rendering the view if the user exists
      render :show
    else
      # Handle the case when the user doesn't exist
      redirect_to root_path, alert: 'User not found'
    end
  end
end

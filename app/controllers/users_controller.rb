class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = user.find(param[:id])
  end
end

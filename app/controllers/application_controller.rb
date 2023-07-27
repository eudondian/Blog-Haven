class ApplicationController < ActionController::Base
  def current_user
    User.first
    # User.find(params[:user_id])
  end
  # helper_method :current_user
end

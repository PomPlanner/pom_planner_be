class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :require_login, only: [:show]

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_login
    unless session[:user_id]
      # redirect_to root_path, alert: "You must be logged in to access this section"
    end
  end
end

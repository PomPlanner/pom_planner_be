class Api::V1::UsersController < ApplicationController
  # before_action :require_login, only: [:show]

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user).serializable_hash
  end

  private

  def require_login
    # unless session[:user_id].present?
    unless request.env["omniauth.auth"]
      render json: { error: "You must be logged in to access this section" }, status: :unauthorized
    end
  end
end

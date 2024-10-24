class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])
    if user
      render json: UserSerializer.new(user).serializable_hash
    else
      Rails.logger.error("User with ID #{params[:id]} not found")
      render json: { error: "User not found" }, status: :not_found
    end
  rescue => e
    Rails.logger.error("Error fetching user: #{e.message}")
    render json: { error: "Internal server error: #{e.message}" }, status: :internal_server_error
  end
end

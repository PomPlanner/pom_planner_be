class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    require 'pry'; binding.pry
    render json: UserSerializer.new(user).serializable_hash
  end
end

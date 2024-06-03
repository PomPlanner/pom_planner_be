class API::V1::UserVideosController < ApplicationController
  before_action :set_user

  def create
    begin
    @user_video = @user.user_videos.create(user_video_params)

    render json: { message: 'Video added to favorites' }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(ErrorMessage.new(e.message)).serialize_json, status :not_found
  end

  def destroy
    begin
    @user_video = @user.user_videos.find(params[:id])
    @user_video.destroy

    render json: { message: 'Video removed from favorites' }, status: :ok
    rescue ActiveRecord::ReecordNotFound => e
      render json: ErrorSerializer.new(ErrorMessage.new(e.message)).serialize_json, status :not_found

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_video_params
    params.require(:user_video).permit(:title, :url)
  end
end
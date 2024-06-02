class API::V1::UserVideosController < ApplicationController
  before_action :set_user

  def create
    @user_video = @user.user_videos.create(user_video_params)

    render json: { message: 'Video added to favorites' }, status: :created
  end

  def destroy
    @user_video = @user.user_videos.find(params[:id])
    @user_video.destroy

    render json: { message: 'Video removed from favorites' }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_video_params
    params.require(:user_video).permit(:title, :url)
  end
end
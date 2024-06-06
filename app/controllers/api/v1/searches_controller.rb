class Api::V1::SearchesController < ApplicationController
  def index
    binding.pry
    if params[:query].present? && params[:video_duration].present?
      query_keywords = params[:query]
      video_duration = params[:video_duration]
      
      @videos = YoutubeFacade.search(query_keywords, video_duration)
      render json: @videos
    else
      render json: { error: "Query and video duration parameters are required" }, status: :bad_request
    end
  end
end

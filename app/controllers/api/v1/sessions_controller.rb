class API::V1::SessionsController < ApplicationController

  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      session[:user_id] = user.id 
      redirect_to api_v1_user_path(user)
    else
      redirect_to '/', alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end
class API::V1::SessionsController < ApplicationController

  def omniauth
    user = User.from_omniauth(request.env['omniauth'])
    if user.valid?
      session[:user_id] = user.id 
      redirect_to user_path(user)
    else
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end
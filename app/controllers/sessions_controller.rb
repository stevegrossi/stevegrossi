class SessionsController < ApplicationController
  def new
    if current_user
      flash.now[:error] = "Already logged in as <b>#{current_user.username}</b>."
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to meta_dashboard_path, notice: 'Hey there, good lookin!'
    else
      flash.now[:error] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to posts_path
  end

end

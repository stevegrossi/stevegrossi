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
      flash[:success] = "Hey there, sexy!"
      redirect_back_or_to meta_dashboard_path
    else
      flash.now[:error] = "Incorrect email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "See you around, cowboy."
    redirect_back_or_to root_url
  end

  private

  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end

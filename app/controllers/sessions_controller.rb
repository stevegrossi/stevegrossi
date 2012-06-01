class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "Hey there, sexy!"
      redirect_back_or_to root_url
    else
      flash[:error] = "Incorrect email or password."
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

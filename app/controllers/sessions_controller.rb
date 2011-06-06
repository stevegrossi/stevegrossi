class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "Hey there, sexy!"
      redirect_to root_url
    else
      flash[:success] = "Incorrect email of password."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "See you around, cowboy."
    redirect_to root_url
  end
end

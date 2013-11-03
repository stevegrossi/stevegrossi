class UsersController < ApplicationController
  before_filter :logged_in?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Your ass signed up!'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :birthdate)
  end
end

class ApplicationController < ActionController::Base

  protect_from_forgery

  def after_sign_in_path_for(user)
    session[:user_return_to] || meta_dashboard_path
  end

end

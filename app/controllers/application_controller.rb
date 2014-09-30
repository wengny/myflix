class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user # !! convert object to boolean
  end

  def require_user
    redirect_to sign_in_path, notice: 'You need to sign in!' unless logged_in?
  end


end

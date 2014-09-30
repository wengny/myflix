class SessionsController < ApplicationController
  
  def new 
    # no sign in page if user is logged in
    redirect_to home_path if logged_in?
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'You are signed in!'
    else
      flash[:error] = "Invalid email or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You are signed out!'
  end
end
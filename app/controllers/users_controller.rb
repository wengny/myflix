class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: 'You are registered!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name )
  end
end
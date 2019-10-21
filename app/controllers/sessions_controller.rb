class SessionsController < ApplicationController

  def welcome
  end

  def login
  end

  def destroy
    session.clear
    redirect_to '/'
  end

  def signup
  end

  def new
  end 

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user.try(:authenticate, params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Sorry, login info was incorrect. Please try again."
      redirect_to login_path
    end
  end

end

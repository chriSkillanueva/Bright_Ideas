class SessionsController < ApplicationController

  def create
    user = User.find_by email: params[:email]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/bright_ideas"

    else
      flash[:login_error] = "Invalid Email/Password Combination"
      redirect_to "/"
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end
end

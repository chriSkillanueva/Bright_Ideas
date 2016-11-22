class UsersController < ApplicationController
  before_action :require_login, except: [:index, :create]

  def index
  end

  def create
    user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:confirm], alias: params[:alias])
    if user.save
      session[:user_id] = user.id
      redirect_to "/bright_ideas"
    else
      errors = user.errors
      flash[:name_error] = errors['name'].join(", ").capitalize
      flash[:email_error] = errors['email'].join(", ").capitalize
      flash[:password_error] = errors['password'].join(", ").capitalize
      flash[:confirm_error] = errors['password_confirmation'].join(", ").capitalize
      flash[:alias_error] = errors['alias'].join(", ").capitalize
      redirect_to '/'
    end
  end

  def show
    @current = User.find(session[:user_id])
    @user = User.find(params[:id])
  end
end

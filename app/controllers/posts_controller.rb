class PostsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
    @user = User.find(session[:user_id])
    @ideas = Post.all.sort {|x,y| y.likes.count <=> x.likes.count}
  end

  def create
    new = Post.new(content: params[:idea], user_id: params[:user_id])

    if new.save
      redirect_to "/bright_ideas"

    else
      errors = new.errors
      flash[:idea_error] = errors['content'].join(", ").capitalize
      redirect_to "/bright_ideas"
    end
  end

  def show
    @user = User.find(session[:user_id])
    @idea = Post.find(params[:id])
  end

  def destroy
    idea = Post.find(params[:id])
    if idea.user == current_user
      idea.destroy
      redirect_to "/bright_ideas"
    else
      flash[:loser] = "You Can't Do That"
      redirect_to "/bright_ideas"
    end
  end
end

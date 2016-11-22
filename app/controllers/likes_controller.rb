class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  
  def create
    Like.create(user_id: params[:user_id], post_id: params[:idea_id])
    redirect_to "/bright_ideas"
  end

  def destroy
    like = Like.find(params[:id])
    if like.user == current_user
      like.destroy
      redirect_to "/bright_ideas"
    else
      flash[:loser] = "You Can't Do That"
      redirect_to "/bright_ideas"
    end
  end
end

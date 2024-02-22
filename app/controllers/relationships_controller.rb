class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    # userモデルに記述したfollowメソッド
    redirect_to request.refer
  end
  
  def destroy
    
  end
end

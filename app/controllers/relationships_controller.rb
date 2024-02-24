class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    # userモデルに記述したfollowメソッド、引数は上paramsで取得したuser_id
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  # ここからフォロー機能
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    # active_relationshipsという名称で参照したrelationshipsテーブル経由で、
    # userによってフォローされているユーザー一覧であるfollowedカラムを返し、@usersに格納
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    # passive_relationshipsという名称で参照したrelationshipsテーブル経由で、
    # userをフォローしているユーザー一覧であるfollowerカラムを返し、@usersに格納
  end
end

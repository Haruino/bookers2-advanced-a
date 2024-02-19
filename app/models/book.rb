class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    # いいねを押したfavoritesテーブルのuser_idと引数である関連付けられたuserテーブルの
    # idが存在している場合はいいねされている、存在していない場合はいいねされていない
  end
end

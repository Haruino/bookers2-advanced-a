class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # favoritesモデルを介してuserモデルのデータを持ってくる
  
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    # いいねを押したfavoritesテーブルのuser_idと引数である関連付けられたuserテーブルの
    # idが存在している場合はいいねされている、存在していない場合はいいねされていない
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
    
    # titleは検索対象であるbooksテーブル内のカラム名
  end
end

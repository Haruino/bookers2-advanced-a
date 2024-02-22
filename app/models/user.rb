class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # ユーザーモデル（User）がフォローしている関連付（フォローする側）、active_relationshipsという名前で参照、
  # クラスネームをつけることでどのテーブルを参照しているか判別させる
  # 「follower_id」という外部キーを持つRelationshipモデルの複数のインスタンスの集合
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローされている関連付け、passive_relationshipsという名前で参照
  # フォローする側とされる側の重複を防ぐために名前をつける
  has_many :followings, through: :active_relationships, source: :followed
  # ユーザーがフォローしているユーザー全員を取得
  # Userモデルは、active_relationships経由（中間テーブル経由）でfollowings（フォローしているユーザー）と関連付けられる
  # followings,followersは実際には存在しない、どちらもUserなので区別するためにUserテーブルに任意の名前をつける
  # source: :followedにより、active_relationshipsテーブルのfollowedカラム
  # （中間テーブルを通ったあるユーザーによってフォローされる人全員＝あるユーザーがフォローしている人全員）を参照
  has_many :followers, through: :passive_relationships, source: :follower
  # ユーザーのフォロワーであるユーザー全員を取得
   # source: :followerにより、passive_relationshipsテーブルのfollowerカラム（あるユーザーをフォローしている人全員）を参照
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  # active_relationshipsを経由して指定したユーザーをフォロー
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  # 指定したユーザーのフォローを解除
  
  def following?(user)
     followings.include?(user)
  end
  # 指定したユーザーをフォローしているかどうかを判定

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end

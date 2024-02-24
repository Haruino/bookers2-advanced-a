class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  # フォローする側、架空のfollowerテーブルに属すると仮定
  belongs_to :followed, class_name: "User"
  # フォローされる側、架空のfollowedテーブルに属すると仮定
end

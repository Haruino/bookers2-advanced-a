class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  # フォローする側
  belongs_to :followed, class_name: "User"
  # フォローされる側
end

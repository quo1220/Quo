class Comment < ApplicationRecord
  validates :message, {presence: true}
  validates :post_id, {presence: true}
  validates :user_id, {presence: true}

  belongs_to :post
  belongs_to :user
  belongs_to :comment, class_name: "Comment", optional: true
  has_many :comments,  class_name: "Comment",foreign_key: "comment_id", dependent: :destroy

  

end

class Post < ApplicationRecord
  validates :detail, {presence: true, length: {maximum: 500}}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :post_type, {presence: true}

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :suggests, dependent: :destroy

end

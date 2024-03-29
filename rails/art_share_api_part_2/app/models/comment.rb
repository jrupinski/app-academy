class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :artwork
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  has_many :likes, as: :likeable
  has_many :liked_users,
          through: :likes,
          source: :user
end

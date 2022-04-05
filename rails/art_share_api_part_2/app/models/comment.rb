class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :artwork
  belongs_to :author, class_name: 'User'
end

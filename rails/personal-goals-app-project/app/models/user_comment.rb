class UserComment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :user

  validates :body, presence: true
end

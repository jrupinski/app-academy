class Like < ApplicationRecord
  # validates :user, presence: true
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end

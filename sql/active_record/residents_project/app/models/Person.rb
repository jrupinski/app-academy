class Person < ApplicationRecord
  validates :name, :house_id, presence: true
end
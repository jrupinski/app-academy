class Album < ApplicationRecord
  belongs_to :band

  validates :name, :year, :live, presence: true
  validates :name, uniqueness: { scope: :band }
  validates :year, numericality: { only_integer: true, greater_than: 1900, less_than: 9999 }
  validates :live, inclusion: [true, false]
end

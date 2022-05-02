class Track < ApplicationRecord
  validates :title, :ord, :band, :album, presence: true
  validates :bonus, inclusion: [true, false]
  validates :ord, numericality: { only_integer: true, greater_than: 0, less_than: 999 }, uniqueness: { scope: :album }

  belongs_to :album
  belongs_to :band

  has_many :notes, dependent: :destroy
end

class Album < ApplicationRecord
  belongs_to :band

  validates :name, :year, presence: true
  validates :name, uniqueness: { scope: :band }
  validates :year, numericality: { only_integer: true, greater_than: 1900, less_than: 9999 }
  validates :live, inclusion: [true, false]

  after_initialize :set_defaults

  private

  def set_defaults
    self.live ||= false
  end
end

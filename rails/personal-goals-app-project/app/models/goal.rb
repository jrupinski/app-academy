class Goal < ApplicationRecord
  belongs_to :user

  has_many :goal_comments

  validates :title, presence: true, length: { minimum: 6 }
  validates :completed, :private, inclusion: [true, false]

  def toggle_complete
    toggle(:completed)
  end

  def toggle_private
    toggle(:private)
  end
end

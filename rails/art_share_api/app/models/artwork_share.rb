class ArtworkShare < ApplicationRecord
  validates :artwork, uniqueness: { scope: :viewer }

  belongs_to :viewer, class_name: 'User'
  belongs_to :artwork
end

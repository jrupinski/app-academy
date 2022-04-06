class ArtworkShare < ApplicationRecord
  validates :artwork_id, uniqueness: { scope: :viewer_id }
  validates :favorite, inclusion: [true, false]

  belongs_to :artwork
  belongs_to :viewer, class_name: 'User'
end

class User < ApplicationRecord
  validates :username, uniqueness: true

  has_many :artworks,
           foreign_key: :artist_id,
           dependent: :destroy
  has_many :artwork_shares,
           foreign_key: :viewer_id,
           dependent: :destroy
  has_many :shared_artworks,
            through: :artwork_shares,
            source: :artwork
end

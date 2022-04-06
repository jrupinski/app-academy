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
  has_many :comments, dependent: :destroy, foreign_key: :author_id
  has_many :likes
  has_many :liked_artworks,
           through: :likes,
           source: :likeable,
           source_type: 'Artwork'
  has_many :liked_comments,
           through: :likes,
           source: :likeable,
           source_type: 'Comment'
end

class Artwork < ApplicationRecord
  validates :title, :image_url, :artist, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id, message: 'Artist can not have 2 artworks with the same name' }

  belongs_to :artist, foreign_key: :artist_id, class_name: 'User'
end

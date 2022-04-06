class Artwork < ApplicationRecord
  validates :title, :image_url, :artist_id, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id, message: 'Artist can not have 2 artworks with the same name' }
  validates :favorite, inclusion: [true, false]

  belongs_to :artist, foreign_key: :artist_id, class_name: 'User'
  has_many :artwork_shares
  has_many :shared_viewers, through: :artwork_shares, source: :viewer
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :liked_users,
           through: :likes,
           source: :user
end

class User < ApplicationRecord
  validates :username, uniqueness: true

  def shared_artworks
    ArtworkShare.where(viewer_id: id)
  end
end

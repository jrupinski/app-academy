# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # prefetch tracks without any data
    albums = self.albums.includes(:tracks)
    tracks_count = {}

    albums.each do |album|
      # i use #length to avoid rails firing up another query, because data
      # is already prefetched in #includes(:tracks)
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
    # 3 queries total 
  end
end

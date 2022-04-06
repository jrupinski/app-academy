class AddFavoriteColumnToArtworksAndSharedArtworks < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :favorite, :boolean, default: false
    add_column :artwork_shares, :favorite, :boolean, default: false
  end
end

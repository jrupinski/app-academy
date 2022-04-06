class ArtworksController < ApplicationController
  def index
    render json: Artworks.all
  end

  def favorite
    artwork = Artwork.find(params[:id])
    favorite = artwork.favorite

    if artwork.update(favorite: !favorite)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end
end

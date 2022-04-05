class ArtworksController < ApplicationController
  def index
    render json: Artworks.all
  end
end

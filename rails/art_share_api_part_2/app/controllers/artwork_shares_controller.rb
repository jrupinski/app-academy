class ArtworkSharesController < ApplicationController
  def create
    artwork_share = ArtworkShare.new(artwork_share_params)

    if artwork_share.save
      render json: artwork_share
    else
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork_share = ArtworkShare.find(params[:id])

    artwork_share.delete
  end

  def favorite
    artwork_share = ArtworkShare.find(params[:id])
    favorite = artwork_share.favorite

    if artwork_share.update(favorite: !favorite)
      render json: artwork_share
    else
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end
end

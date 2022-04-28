class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    album = Album.new(album_params)

    if album.save
      redirect_to album_path(album.id)
    else
      flash.now[:errors] = album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    album = Album.find(params[:id])
    album.update(album_params)

    if album.save
      redirect_to album_path(album.id)
    else
      flash.now[:errors] = album.errors.full_messages
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])
    if album&.destroy
      flash[:alerts] = [" Album \"#{album.name}\" has been deleted"]
      redirect_to bands_path
    else
      flash[:errors] = album.errors.full_messages
      redirect_to album_path(album.id)
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :year, :live, :band_id)
  end
end

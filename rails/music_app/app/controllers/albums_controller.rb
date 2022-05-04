class AlbumsController < ApplicationController
  before_action :redirect_if_not_logged_in

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
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_path(@album.id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_path(band_id: album_params[:band_id])
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_path(@album.id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to edit_album_path(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album&.destroy
      flash[:notice] = " Album \"#{@album.name}\" has been deleted"
      redirect_to bands_path
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to album_path(@album.id)
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :year, :live, :band_id)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end

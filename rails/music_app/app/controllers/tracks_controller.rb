class TracksController < ApplicationController
  before_action :redirect_if_not_logged_in

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new(album_id: params[:album_id])

    render :new
  end

  def create
    @track = Track.new(track_params)
    @track.band_id = Album.find(track_params[:album_id]).band_id

    if @track.save
      redirect_to track_path(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update(track_params)

    if @track.save
      redirect_to track_path(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track&.destroy
      flash[:alerts] = [" Track \"#{@track.name}\" has been deleted"]
      redirect_to albums_path
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to track_path(@track.id)
    end
  end

  private

  def track_params
    params.require(:track).permit(:title, :ord, :bonus, :lyrics, :album_id)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end

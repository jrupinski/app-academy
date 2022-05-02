class BandsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_path(@band.id)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)

    if @band.save
      redirect_to band_path(@band.id)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      flash[:alerts] = [" Band \"#{@band.name}\" has been deleted"]
      redirect_to new_band_path
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to band_path(@band.id)
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end

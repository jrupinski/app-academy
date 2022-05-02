class NoteController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to note_path(@note)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)

    if @note.save
      redirect_to note_path(@note.id)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note&.destroy
      flash[:alerts] = [" Note has been deleted"]
      redirect_to :back
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to note_path(@note.id)
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end

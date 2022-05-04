class NotesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def create
    note = current_user.notes.new(note_params)
    note.save
    flash[:errors] = note.errors.full_messages
    redirect_to track_path(note.track_id)
  end

  def destroy
    note = current_user.notes.find(params[:id])
    note.destroy
    flash[:notice] = 'Note has been deleted'
    redirect_to track_path(note.track_id)
  end

  private

  def note_params
    params.require(:note).permit(:body, :user_id, :track_id)
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless logged_in?
  end
end

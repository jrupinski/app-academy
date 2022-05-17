class UserCommentsController < ApplicationController
  before_action :require_current_user!

  def create
    @comment = UserComment.new(user_comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notice] = 'Comment saved!'
    else
      flash[:errors] = @comment.errors.full_messages
      head :unprocessable_entity
    end

    redirect_back fallback_location: users_path
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(
      :body,
      :user_id
    )
  end
end

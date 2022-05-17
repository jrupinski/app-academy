class CommentsController < ApplicationController
  before_action :require_current_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notice] = 'Comment saved!'
    else
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_back fallback_location: users_path
  end

  private

  def comment_params
    params.require(:comment).permit(
      :body,
      :commentable_id,
      :commentable_type
    )
  end
end

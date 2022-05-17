class GoalCommentsController < ApplicationController
  before_action :require_current_user!

  def create
    @comment = GoalComment.new(goal_comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notice] = 'Comment saved!'
    else
      flash[:errors] = @comment.errors.full_messages
      head :unprocessable_entity
    end

    redirect_back fallback_location: goals_path
  end

  private

  def goal_comment_params
    params.require(:goal_comment).permit(
      :body,
      :goal_id
    )
  end
end

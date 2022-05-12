class GoalsController < ApplicationController
  before_action :require_current_user!

  def index
    @goals = current_user.goals
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goal_path(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(
      :title,
      :description,
      :completed,
      :private,
      :user_id
    )
  end
end

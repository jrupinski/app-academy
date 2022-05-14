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
      flash[:notice] = 'Goal saved!'
      redirect_to goal_path(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      flash[:notice] = 'Goal updated!'
      redirect_to goal_path(@goal.id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "Goal deleted!"
    redirect_to goals_url
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

class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    if user.persisted?
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])

    user.update(user_params)

    render json: user
  end

  def index
    render json: User.all
  end


  def user_params
    params.require(:user).permit(:name, :email)
  end
end

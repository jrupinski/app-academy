class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to json: @user, status: :created
    else
      render :new, status: :unprocessable_entity
      flash.now[:errors] = @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      login_user!(user)
      redirect_to root_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_back fallback_location: new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def redirect_if_logged_in
    redirect_to root_path if current_user
  end
end

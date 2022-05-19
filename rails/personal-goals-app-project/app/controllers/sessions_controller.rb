class SessionsController < ApplicationController
  before_action :require_no_current_user!, only: %i[new create]
  before_action :require_current_user!, only: %i[index destroy]

  def new
    @user = User.new
  end

  def create
    email = user_params[:email]
    password = user_params[:password]
    @user = User.find_by_credentials(email: email, password: password)

    if @user
      login!(@user)
      redirect_to user_path(@user)
    else
      flash.now[:errors] = ['Invalid credentials']
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout!
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

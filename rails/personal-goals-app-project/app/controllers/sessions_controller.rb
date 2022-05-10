class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = user_params[:email]
    password = user_params[:password]
    @user = User.find_by_credentials(email: email, password: password)

    if @user
      redirect_to user_path(@user)
    else
      flash.now[:errors] = ['Invalid credentials']
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

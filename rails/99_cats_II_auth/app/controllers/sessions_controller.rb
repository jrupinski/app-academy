class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(username: user_params[:username], password: user_params[:password])

    if user.nil?
      flash[:errors] = ['Wrong username or password']
    else
      login_user!(user)
    end

    redirect_to root_url
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

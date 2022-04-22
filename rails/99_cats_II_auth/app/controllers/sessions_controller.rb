class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

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

  def redirect_if_logged_in
    redirect_to root_path if current_user
  end
end

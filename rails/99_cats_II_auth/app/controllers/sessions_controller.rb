class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(username: user_params[:username], password: user_params[:password])

    if @user.nil?
      flash[:errors] = ['Wrong username or password!']
      redirect_to new_session_url
    else
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

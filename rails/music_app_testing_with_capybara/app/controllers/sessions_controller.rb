class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    render :new
  end

  def create
    email = session_params[:email]
    password = session_params[:password]
    user = User.find_by_credentials(email: email, password: password)

    if user
      login_user!(user)
      redirect_to user_path(user)
    else
      flash[:errors] = ['Username or password is not valid']
      redirect_to new_session_path
    end
  end

  def destroy
    logout!
    redirect_to new_session_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_if_logged_in
    redirect_to user_path(current_user) if logged_in?
  end
end

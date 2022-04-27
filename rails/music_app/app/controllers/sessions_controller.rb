class SessionsController < ApplicationController
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
      render :new
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
end

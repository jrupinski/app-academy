class ApplicationController < ActionController::Base
  helper_method :login_user!, :logout!, :current_user

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user&.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    current_session_token = session[:session_token]
    User.find_by(session_token: current_session_token)
  end
end

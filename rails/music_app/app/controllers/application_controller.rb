class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def login_user!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    current_user&.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    current_session_token = session[:session_token]
    return nil if current_session_token.nil?

    @current_user ||= User.find_by(session_token: current_session_token)
  end

  def logged_in?
    current_user.present?
  end
end

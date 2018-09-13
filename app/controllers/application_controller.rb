class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user
  
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logout_user!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end
end

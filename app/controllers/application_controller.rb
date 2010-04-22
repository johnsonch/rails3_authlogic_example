class ApplicationController < ActionController::Base 
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      redirect_to new_user_session_url, :notice => "You must be logged in to access this page"
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      redirect_to account_url, :notice => "You must be logged out to access this page"
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default, options = {})
    redirect_to((session[:return_to] || default), options)
    session[:return_to] = nil
  end
end

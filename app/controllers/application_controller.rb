# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  TITLE = I18n.t(:application_title)

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'application'

  # Scrub sensitive parameters from your log
  #filter_parameter_logging :password, :password_confirmation, :confirm_password
  helper_method :current_user_session, :current_user, :logged_in?


  private

  def logged_in?
    !current_user_session.nil?
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page."
      redirect_to login_url
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end


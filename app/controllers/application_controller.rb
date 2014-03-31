class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  helper_method :current_user

  def disable_nav
    @disable_nav = true
  end


  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def require_login
    targetController = params[:controller]
    targetAction = params[:action]
    
    if current_user
      # DO NOTHING
    else
      if (targetController == "users" and targetAction == "index")
        # DO NOTHING
      else
        redirect_to "/"
      end
    end
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

end

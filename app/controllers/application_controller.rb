class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories
  helper_method :current_user
  helper_method :require_admin

  def get_categories
    # @categories ||= Category.all
    @categories = Category.all
  end

  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        # log_in user
        @current_user = user
      end
    end
  end

  def require_user
    redirect_to '/login' unless current_user
    store_location
    # flash[:notice] = "You must be logged in to access this page"
    # redirect_to '/login'
    return false
  end

  def require_admin
    redirect_to '/' unless current_user.admin?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember_me
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    forget(@current_user)
    session[:user_id] = nil
    @current_user = nil
  end

  def store_location
    session[:return_to] = request.url
  end

end

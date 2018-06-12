class SessionsController < ApplicationController
  before_filter :require_user, :only => :destroy

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # remember @user
      redirect_to '/'
    else
      redirect_to login_path, notice: 'Invalid email/password'
    end
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def destroy
    log_out if logged_in?
    redirect_to '/'
  end
end

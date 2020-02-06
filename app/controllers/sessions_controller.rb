class SessionsController < ApplicationController
  # con esto defininos middlewares

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :user_invited, only: [:new, :create]

  def user_invited
    if logged_in?
      redirect_to home_url
    end
  end

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to home_path
    else
      flash.now[:danger] = 'Email o password incorrectos'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end

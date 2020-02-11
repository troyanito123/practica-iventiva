class ApplicationController < ActionController::Base
  # esto estaba en la documentacion no se para que sera...
  # protect_from_forgery with: :exception
  # before actions check current user
  include SessionsHelper
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_not_authorized
    flash[:warning] = "Access denied."
    redirect_to home_path
  end
end

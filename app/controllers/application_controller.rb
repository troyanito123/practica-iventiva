class ApplicationController < ActionController::Base
  # esto estaba en la documentacion no se para que sera...
  # protect_from_forgery with: :exception
  # before actions check current user
  include SessionsHelper

  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end

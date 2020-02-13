class PasswordResetsController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]    # Case (1)
  before_action -> { authorize PasswordReset }


  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = I18n.t 'reset_instructions'
      redirect_to login_path
    else
      flash[:danger] = I18n.t 'no_email'
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = I18n.t 'reset_password'
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.authenticated?(:reset, params[:id]))
      flash[:danger] = I18n.t 'invalid_link_reset'
      redirect_to login_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = I18n.t 'reset_expired'
      redirect_to new_password_reset_url
    end
  end
end

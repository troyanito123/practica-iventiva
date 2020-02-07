class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :user_invited, only: [:new, :create]
  before_action :set_user, only: [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = I18n.t 'login_success'
      redirect_to login_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to home_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private
  def handle_record_not_found
    flash[:danger] = I18n.t 'not_current_user'
    redirect_to home_path
  end

  private
  def set_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = I18n.t 'not_current_user'
      redirect_to home_path
    end
  end

end

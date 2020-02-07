class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]

  before_action :user_invited, only: [:new, :create]

  def user_invited
    if logged_in?
      redirect_to home_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = 'Ingresa tus datos para poder acceder!'
      redirect_to login_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

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
end

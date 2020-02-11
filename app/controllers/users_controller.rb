class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  before_action -> { authorize @user || User }

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @roles = Role.all
    @user = User.new(user_params)
    if logged_in? && current_user.admin?
      @user.role = Role.find(params[:user][:role])
    else
      @user.role = Role.find_by(code: "USER")
    end
    if @user.save
     flash[:success] = I18n.t 'login_success'
     redirect_to users_path
    else
     render 'new'
    end
  end

  def edit
    @roles = Role.all
  end

  def update

    @user.assign_attributes user_params
    if logged_in? && current_user.admin?
      @user.role = Role.find(params[:user][:role])
    else
      @user.role = Role.find_by(code: "USER")
    end
    if @user.save
      flash[:success] = I18n.t 'user_update'
      if current_user.role.code == 'ADMIN'
        redirect_to users_path
      else
        redirect_to articles_path
      end

    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = I18n.t 'user_delete'
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private
  def handle_record_not_found
    flash[:danger] = I18n.t 'user_not_found'
    redirect_to home_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end

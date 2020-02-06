class SessionsController < ApplicationController
  # skip before action ()
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to home_path
    else
      flash.now[:danger] = 'Email o password incorrectos'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

end

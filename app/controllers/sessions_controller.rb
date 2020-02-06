class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to home_path
    else
      flash[:danger] = 'Email o password incorrectos'
      render 'new'
    end
  end
end

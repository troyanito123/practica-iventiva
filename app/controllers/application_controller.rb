class ApplicationController < ActionController::Base
  # esto estaba en la documentacion no se para que sera...
  # protect_from_forgery with: :exception
  # before actions check current user
  include SessionsHelper

  #def metodo
  #  if !logged_in?
  #    # redirigir
  #  end
  #end
end

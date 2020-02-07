class HomeController < ApplicationController

  include SessionsHelper

  def index
    @articles = Article.all
  end
end

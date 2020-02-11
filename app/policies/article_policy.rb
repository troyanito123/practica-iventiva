class ArticlePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

end
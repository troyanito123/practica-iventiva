class PasswordResetsPolicy < ApplicationPolicy
  def new?
    user.nil?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end
end
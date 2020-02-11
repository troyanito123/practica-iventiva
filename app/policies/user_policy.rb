class UserPolicy < ApplicationPolicy

  def new?
    if user
      !user.normal_user?
    else
      true
    end
  end

  def create?
    new?
  end

  def update?
    user.admin? || user == record
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
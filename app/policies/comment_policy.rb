class CommentPolicy < ApplicationPolicy
  def create?
    user.admin? || user.normal_user?
  end

  def destroy?
    user.admin? || user == record.user
  end
end
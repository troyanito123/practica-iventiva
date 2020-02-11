class CommentPolicy < ApplicationPolicy
  def create?
    user.admin? || user.normal_user?
  end

  def destroy?
    # user.admin? || user == record.user
    # puts("QUE HAY EN EL RECORD: #{record.inspect}")
  end
end
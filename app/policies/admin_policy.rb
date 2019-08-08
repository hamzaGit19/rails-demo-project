# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.admin?
    # return true if @user.admin?
  end

  def update?
    return true if @user.admin?
  end

  def edit?
    return true if @user.admin?
  end

  def destroy?
     if @record.admin?
      # @counter = Admin.size
      return false if Admin.count == 1
    else
      @user.admin?
    end
  end

  def new_user?
    return true if @user.admin?
  end

  def is_admin?
    return true if @user.admin?
  end

  private
end

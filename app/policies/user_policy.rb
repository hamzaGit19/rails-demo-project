# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def new?
    return true if @user.admin? || @user.manager?
  end

  def add_user?
    return true if @user.admin? || @user.manager?
  end
end

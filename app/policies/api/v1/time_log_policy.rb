# frozen_string_literal: true

class Api::V1::Admin::TimeLogPolicy < ApplicationPolicy
  def create?
    @user.admin? || @user.manager? || @user.employee?
  end

  def update?
    @user.admin? || @user.manager?
  end

  def destroy?
    @user.admin? || @user.manager?
  end
end

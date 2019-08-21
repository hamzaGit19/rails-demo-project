# frozen_string_literal: true

class Api::V1::PaymentPolicy < ApplicationPolicy
  def create?
    @user.admin? || @user.manager?
  end

  def update?
    @user.admin? || @user.manager?
  end

  def destroy?
    @user.admin? || @user.manager?
  end
end

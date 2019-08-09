# frozen_string_literal: true

class Manager::PaymentPolicy < ApplicationPolicy
  def index?
    @user.manager?
  end

  def create?
    @user.manager?
  end

  def update?
    @user.manager?
  end

  def edit?
    @user.manager?
  end

  def destroy?
    @user.manager?
  end

  def show?
    @user.manager?
  end

  def new?
    @user.manager?
  end
end

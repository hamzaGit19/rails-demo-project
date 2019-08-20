# frozen_string_literal: true

class Api::V1::ProjectPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def create?
    @user.admin? || @user.manager?
  end

  def update?
    @user.admin? || @user.manager?
  end

  def edit?
    @user.admin?
  end

  def destroy?
    @user.admin? || @user.manager?
  end

  def show?
    @user.admin?
  end

  def new?
    @user.admin?
  end
end

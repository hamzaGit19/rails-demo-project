# frozen_string_literal: true

class Api::V1::Admin::UserPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def destroy?
    byebug
    @user.admin?
  end

  def new?
    @user.admin?
  end
end

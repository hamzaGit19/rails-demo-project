# frozen_string_literal: true

class Api::V1::Admin::ClientPolicy < ApplicationPolicy
  def index?
    byebug
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
    @user.admin?
  end

  def show?
    @user.admin?
  end

  def new?
    @user.admin?
  end
end

# frozen_string_literal: true

class ManagerPolicy < ApplicationPolicy
  attr_reader :subject

  def index?
    true
  end

  def create?
    return true if @user.manager?
  end

  def update?
    !@record.admin?
  end

  def edit?
    !@record.admin?
  end

  def destroy?
    !@record.admin?
  end

  def new_user?
    return true if @user.manager?
  end

  def is_manager?
    return true if @user.manager?
  end

  private
end

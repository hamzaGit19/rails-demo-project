# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def is_admin?
    return true if @user.admin?
  end

  def is_allowed?   
    return true if @user.admin? or @user.manager?
    return true if @record.employees.include? @user 
  end
end

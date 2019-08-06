# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def is_admin?
    return true if @user.admin?
  end
end

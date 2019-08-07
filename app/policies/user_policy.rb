# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
    def is_allowed?
      return true if @user.admin? or @user.manager?
    end
  end
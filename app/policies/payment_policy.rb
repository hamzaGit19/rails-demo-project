# frozen_string_literal: true

class PaymentPolicy < ApplicationPolicy
    def is_admin?
      return true if @user.admin?
    end
    def is_allowed?
        return true if @user.admin? or @user.manager?
      end
  end
  
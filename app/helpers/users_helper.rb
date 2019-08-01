# frozen_string_literal: true

module UsersHelper
  def options_for_user_types
    if current_user.admin?
      options = [%w[Admin],
                 %w[Manager], %w[Employee]]
    elsif current_user.manager?
      options = [%w[Employee]]
    end
  end
end

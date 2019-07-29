# frozen_string_literal: true

module UsersHelper
  def options_for_user_types
    [%w[Admin],
     %w[Client], %w[Manager], %w[Employee]]
  end

end

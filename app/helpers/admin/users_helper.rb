# frozen_string_literal: true

module Admin::UsersHelper
  def options_for_status2
    [%w[Enabled true],
     %w[Disabled false]]
  end

  def get_status(status)
    status == true ? 'Active' : 'inactive'
  end
end

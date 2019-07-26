# frozen_string_literal: true

module RegistrationsHelper
  def options_for_status
    [
      %w[Admin Admin],
      %w[Manager Manager],
      %w[Client Client]
    ]
  end

  

end

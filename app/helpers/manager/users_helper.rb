# frozen_string_literal: true

module Manager::UsersHelper
  def getStatus(type)
    if type.eql? 'false'
      'Inactive'
    else
      'Active'
    end
  end
end

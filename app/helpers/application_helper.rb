# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end

  def get_nav_color
    if current_user.nil?
      @navbar_color = 'navbar navbar-expand-lg navbar-light bg-light'
    else
      @navbar_color = 'navbar navbar-expand-lg navbar-light bg-manager' if current_user.manager?
      @navbar_color = 'navbar navbar-expand-lg navbar-light bg-admin' if current_user.admin?
      @navbar_color = 'navbar navbar-expand-lg navbar-light bg-employee' if current_user.employee?
    end
    @navbar_color
  end
end

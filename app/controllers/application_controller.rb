# frozen_string_literal: true

class ApplicationController < ActionController::Base
 
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:name, :email, :password, :type) }
    devise_parameter_sanitizer.permit(:account_update) { |user| user.permit(:name, :email, :type, :password, :current_password) }
  end
end

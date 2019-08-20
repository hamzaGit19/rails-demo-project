# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_user

  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    render json: { error: 'not_found' }
  end

  private

  def unauthorized_user
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |user| user.permit(:name, :email, :password, :type) }
    devise_parameter_sanitizer.permit(:account_update) { |user| user.permit(:name, :email, :type, :password, :current_password) }
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'application/error404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end

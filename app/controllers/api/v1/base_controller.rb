# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ActionController::Serialization
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_user

  before_action :authorize_request

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def render_errors(object)
    render json: { status: 'Forbidden', code: 'WRONG_DATA', fallback_msg: object.errors.full_messages.join(', ') }
  end

  def render_success(message = nil, object = nil)
    message ||= I18n.t("#{controller_name}.message.#{action_name}")
    render json: { status: 'OK', code: 'OK', fallback_msg: message, object: object }
  end
end

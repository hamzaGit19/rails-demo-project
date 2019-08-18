# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ActionController::Serialization
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  skip_before_action :verify_authenticity_token, only: 'reply', raise: false
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_user
  # skip_before_action :authenticate_user!
  before_action :authenticate_api_key!
  # before_action :start
  # before_action :authenticate_user_from_token!

  # Please do not delete above lines. Add one by one.

  # protect_from_forgery with: :null_session

  # ///////
  def start
    byebug
    token = request.headers['Authorization'].to_s =~ /^Bearer (.*)$/i && Regexp.last_match(1)
    return head :unauthorized unless token

    payload = JWT.decode(token, 'secret', true, algorithm: 'HS256')
    user = User.find_by(email: payload['email'])
    return head :unauthorized unless user
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def call
    user
  end

  def user
    byebug
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end

    nil
  end

  # //////////
  def not_found
    api_error(status: 404, errors: 'Not found')
  end

  protected

  def current_user
    @resource
  end

  def user_signed_in?
    !@resource.nil?
  end

  private

  def authenticate_user_from_token!
    byebug
    @resource ||= user_with_key(apikey_from_request).where(email: claims[0]['user']).first
    raise Pundit::NotAuthorizedError, 'Unable to deserialize JWT token.' if @resource.nil?
  rescue StandardError => e
    Rails.logger.error e
    raise Pundit::NotAuthorizedError, e
  end

  def authenticate_api_key!
    if apikey_from_request.present?
      raise Pundit::NotAuthorizedError, 'Unable to verify the apii key.' unless user_with_key(apikey_from_request).present?
    end
  end

  def claims(token = token_from_request, key: shared_key)
    JWT.decode(token, key, true)
  rescue JWT::DecodeError => e
    raise Pundit::NotAuthorizedError, e
  end

  def jwt_token(user, key: shared_key)
    expires = (DateTime.now + 1.day).to_i
    JWT.encode({ user: user.email, exp: expires }, key, 'HS256')
  end

  def token_from_request
    # Accepts the token either from the header or a query var
    # Header authorization must be in the following format
    # Authorization: Bearer {yourtokenhere}
    auth_header = request.headers['Authorization']
    token = auth_header.try(:split, ' ').try(:last)
    unless Rails.env.production?
      token = request.parameters.try(:[], 'token') if token.to_s.empty?
    end
    token
  end

  def apikey_from_request
    # Accepts the ApiKey either from the header or a query var
    # Header ApiKey must be in the following format
    # ApiKey: {yourkeyhere}
    key = request.headers.try(:[], 'ApiKey').try(:split, ' ').try(:last)
    key = request.parameters.try(:[], 'apikey') if !Rails.env.production? && key.blank?
    key
  end

  def shared_key
    user_secret.tap do |key|
      raise Pundit::NotAuthorizedError, 'Unable to verify the secret.' if key.blank?
    end
  end

  def user_secret
    return if apikey_from_request.nil?

    user_with_key(userkey_from_request).first.try(:shared_secret)
  end

  def user_with_key(key)
    return if apikey_from_request.nil?

    User.where(private_key: key).where('private_key_expires > ?', Time.zone.now)
  end
end

# frozen_string_literal: true

require "#{Rails.root}/lib/json_web_token.rb"

class Api::V1::AuthenticationController < Api::V1::BaseController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user&.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id }),
      user: { id: user.id, email: user.email }
    }
  end
end

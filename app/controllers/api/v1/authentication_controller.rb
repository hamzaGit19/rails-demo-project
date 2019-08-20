# frozen_string_literal: true

require "#{Rails.root}/lib/json_web_token.rb"

class Api::V1::AuthenticationController < Api::V1::BaseController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    # byebug
    @user = User.find_by_email(params[:email])
    if @user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                     email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end

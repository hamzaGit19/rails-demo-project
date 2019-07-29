# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user

  def index
  end

  def edit
  end

  def show
  end

  def new
    @user = User.new
  end

  def add_user
    @user = User.new(user_params)
    if @user.save!
      redirect_to root_path
    end
  end

  def update_password
    @user = current_user
    if @user.update(password_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def set_user
    @user = current_user
  end

  def password_params
    # NOTE: Using `strong_parameters` gem
    params.require(klass.to_s.underscore).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :type, :name)
  end

  def klass
    @user.class
  end
end

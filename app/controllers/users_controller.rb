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

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to dashboard_root_path, notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
        flash[:success] = "Woohoo!"

      else
        format.html { render "users/edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
      render "edit"
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
    params.require(klass.to_s.underscore).permit(:name, :email, :id, :status, :type)
  end


  
  def klass
    @user.class
  end
end

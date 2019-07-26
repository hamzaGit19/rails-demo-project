# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to dashboard_root_path, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to dashboard_root_path, notice: 'User deleted.'
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :email, :id, :status)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def klass
    @user.class
  end
end

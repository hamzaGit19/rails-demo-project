# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
  end

  def update
  end

  def destroy
    @user.destroy
    redirect_to dashboard_root_path, notice: "User deleted."
  end

  def user_params
    params.require(:users).permit(:name, :email, :type, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

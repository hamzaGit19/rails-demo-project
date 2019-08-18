# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  before_action :authenticate_user!

  def index
    query = if params[:name]
              User.where("name LIKE ?", "%#{params[:name]}%")
            else
              User.all.where("id NOT IN(?)", current_user.id)
            end
    if current_user.admin?
    elsif current_user.manager?
      query = query.managerUsers
    end
    @users = query.all
    @users = @users.page(params[:page])
  end

  def search_params
    params.require(:user).permit(:name)
  end

  def new
    authorize(User)
    redirect_to(new_user_registration_path)
  end

  def update
    authorize(User)
    if @user.update(user_params)
      redirect_to dashboard_root_path, notice: "user was successfully updated."
    else
      render :edit
    end
  end

  def edit; end

  def destroy
    authorize(User)
    @user.destroy
    redirect_to dashboard_root_path, notice: "User deleted."
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :email, :id, :status, :image)
  end

  def set_user
    @user = User.find_by_id(params[:id])
    redirect_to(root_url, notice: "User not found") unless @user
  end

  def klass
    @user.class
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end

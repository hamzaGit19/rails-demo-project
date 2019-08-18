# frozen_string_literal: true

class Api::V1::Admin::UsersController < Api::V1::BaseController
  before_action :set_user, only: %i[edit update destroy show]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    # authorize(@user)
    if @user.update(user_params)
      render json: @user
    else
      render json: { error: 'Error updating user.' }
    end
  end

  def destroy
    # authorize(@client)
    @user.destroy
    render json: { message: 'User deleted successfully.' }
  end

  def create
    @user = User.new(user_create_params)
    if @user.save!
      render json: @user
    else
      render json: { message: 'Unable to create user ' }
    end
  end

  def user_create_params
    params.permit(:name, :email, :password, :type)
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.permit(:name, :email, :id, :status, :image)
  end

  def authorize(record, query = nil)
    super([:api, :v1, :admin, record], query)
  end
end

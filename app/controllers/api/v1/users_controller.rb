class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update_attributes(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: { data: "Hrllo" }
  end

  def new
    render json: { data: "Hello testing" }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

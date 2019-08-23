class Api::V1::ProfileController < Api::V1::BaseController
  def show
    render json: @current_user
  end

  def update
    # authorize(@user)
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: { error: "Error updating user." }
    end
  end

  def user_params
    params.permit(:name, :email, :id, :status, :image)
  end
end

# frozen_string_literal: true

class Admin::UsersController < AdminBaseController
  before_action :set_user, only: %i[edit update destroy]

  def index; end

  def new
    authorize(User)
    redirect_to(new_user_registration_path)
  end

  def update
    authorize(@user)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to dashboard_root_path, notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def destroy
    authorize(@user)

    @user.destroy
    redirect_to dashboard_root_path, notice: "User deleted."
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :email, :id, :status, :image)
  end

  def set_user
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      redirect_to dashboard_root_path, notice: "User does not exist."
    end
  end

  def klass
    @user.class
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end

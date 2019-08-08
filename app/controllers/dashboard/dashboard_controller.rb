# frozen_string_literal: true

class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    query = if params[:name]
              User.where('name LIKE ?', "%#{params[:name]}%")
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
end

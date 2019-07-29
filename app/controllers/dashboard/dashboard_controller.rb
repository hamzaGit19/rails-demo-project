# frozen_string_literal: true

class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    query = User.all
    if current_user.admin?
      # Do nothing as per now. Get all the users.
    elsif current_user.manager?
      query = query.managerUsers
    end
    @users = query.all
    @users = @users.page(params[:page])
  end
end

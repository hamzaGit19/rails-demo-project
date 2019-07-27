# frozen_string_literal: true

class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.page(params[:page])
  end
end

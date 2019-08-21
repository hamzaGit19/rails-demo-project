# frozen_string_literal: true

class Manager::UsersController < ApplicationController
  def index
    @users = User.apply_filter(params)
    @users = @users.manager_filter
    @users = @users.page(params[:page])
  end
end

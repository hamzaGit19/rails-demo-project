# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  def index
  end

  def edit
  end

  def show 
  end


  def set_user
    @user = current_user
  end
 
end

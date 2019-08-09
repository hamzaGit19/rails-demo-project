# frozen_string_literal: true

class ManagerBaseController < ApplicationController
  before_action :validate_manager

  def validate_manager
    current_user.manager?
  end
  end

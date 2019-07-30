# frozen_string_literal: true

class ManagerBaseController < ApplicationController
  before_action :validate_manager

  def validate_manager
    authorize User, :is_manager?, policy_class: ManagerPolicy
  end
  end

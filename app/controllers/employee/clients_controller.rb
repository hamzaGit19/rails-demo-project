# frozen_string_literal: true

class Employee::ClientsController < ApplicationController
  before_action :set_client, only: %i[show]

  def show; end

  def index
    @clients = Client.page(params[:page])
  end

  def set_client
    @client = Client.find(params[:id])
  end
end

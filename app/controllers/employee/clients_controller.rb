# frozen_string_literal: true

class Employee::ClientsController < ApplicationController
  before_action :set_client, only: %i[show]

  def show; end

  def index
    @clients = Client.apply_filter(params)
    @clients = @clients.page(params[:page])
  end

  def set_client
    @client = Client.find_by_id(params[:id])
    redirect_to(root_url, notice: 'Client not found') unless @client
  end
end

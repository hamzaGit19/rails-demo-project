# frozen_string_literal: true

class Api::V1::Employee::ClientsController < Api::V1::BaseController
  before_action :set_client, only: %i[show]

  def index
    @clients = Client.all
    render json: @clients
  end

  def show
    render json: @client
  end

  def set_client
    @client = Client.find_by_id(params[:id])
  end
end

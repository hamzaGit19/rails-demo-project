# frozen_string_literal: true

class Api::V1::ClientsController < Api::V1::BaseController
  before_action :set_client, only: %i[edit update destroy show]

  def index
    @clients = Client.apply_filter(params)
    @clients = @clients.page(params[:page])
    render json: @clients
  end

  def create
    @client = Client.new(create_params)
    if @client.save
      render_success("Successfully created the client", @client)
    else
      render_errors(@client)
    end
  end

  def show
    render json: @client
  end

  def update
    if @client.update(create_params)
      render_success("Successfully updated the client", @client)
    else
      render_errors(@client)
    end
  end

  def destroy
    # authorize(@client)
    @client.destroy
    render_success("Successfully deleted the client")
  end

  def create_params
    params.permit(:name, :email, :company, :phone, :referred_by, :country, :compnay_phone)
  end

  def set_client
    @client = Client.find(params[:id])
  end

  def authorize(record, query = nil)
    super([:api, :v1, record], query)
  end
end

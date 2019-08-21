# frozen_string_literal: true

class Manager::ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update destroy show]

  def new
    authorize(Client)
  end

  def show
    authorize(@client)
  end

  def index
    authorize(Client)
    @clients = Client.apply_filter(params)
    @clients = @clients.page(params[:page])
  end

  def edit
    authorize(@client)
  end

  def update
    authorize(@client)

    if @client.update(create_params)
      redirect_to manager_client_path(@client), notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def create
    authorize(Client)
    @client = Client.new(create_params)
    if @client.save
      redirect_to manager_client_path(@client), notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def create_params
    params.require(:client).permit(:name, :email, :company, :phone, :referred_by, :country, :compnay_phone)
  end

  def set_client
    @client = Client.find_by_id(params[:id])
    redirect_to(dashboard_root_path, notice: 'Record not found') unless @client
  end

  def authorize(record, query = nil)
    super([:manager, record], query)
  end
end

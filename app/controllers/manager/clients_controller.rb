# frozen_string_literal: true

class Manager::ClientsController < ManagerBaseController
  before_action :set_client, only: %i[edit update destroy show]

  def new
    authorize(Client)
  end

  def show
    authorize(@client)
  end

  def index
    authorize(Client)
    @clients = Client.page(params[:page])
  end

  def edit
    authorize(@client)
  end

  def update
    authorize(@client)

    respond_to do |format|
      if @client.update(create_params)
        format.html { redirect_to admin_clients_path, notice: "Client was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    authorize(Client)
    @client = Client.new(create_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to dashboard_root_path, notice: "Client was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def create_params
    params.require(:client).permit(:name, :email, :company, :phone, :referred_by, :country, :compnay_phone)
  end

  def set_client
    if Client.exists?(id: params[:id])
      @client = Client.find(params[:id])
    else
      redirect_to dashboard_root_path, notice: "Client does not exist."
    end
  end

  def authorize(record, query = nil)
    super([:manager, record], query)
  end

end

class Api::V1::Manager::ClientsController < Api::V1::BaseController
  before_action :set_client, only: %i[edit update destroy show]

  def index
    @clients = Client.all
    render json: @clients
  end

  def create
    # authorize(Client)
    @client = Client.new(create_params)
    if @client.save
      render json: @client
    else
      render json: { error: "Error Creating client." }
    end
  end

  def show
    render json: @client
  end

  def update
    # authorize(@client)
    if @client.update(create_params)
      render json: @client
    else
      render json: { error: "Error updating client." }
    end
  end

  def destroy
    # authorize(@client)
    @client.destroy
    render json: { message: "Client deleted successfully." }
  end

  def create_params
    params.require(:client).permit(:name, :email, :company, :phone, :referred_by, :country, :compnay_phone)
  end

  def set_client
    @client = Client.find_by_id(params[:id])
  end
end

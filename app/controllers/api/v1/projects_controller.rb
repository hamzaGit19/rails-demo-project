class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :authenticate_request!

  def index
    render json: { "logged_in" => true }
  end
end

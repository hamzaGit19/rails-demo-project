# frozen_string_literal: true

class Api::V1::PaymentsController < Api::V1::BaseController
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new show edit update destroy create]

  def index
    @payments = Payment.all
    render json: @payments
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.project_id = @project.id
    @payment.creator_id = 16
  end

  def destroy
    @payment.destroy
    render json: { message: 'Payment deleted.' }
  end

  def update; end

  def show
    render json: @payment
  end

  private

  def set_payment
    @payment = Payment.find_by_id(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def set_project
    @project = Project.find_by_id(params[:project_id])
  end
end

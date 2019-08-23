# frozen_string_literal: true

class Api::V1::PaymentsController < Api::V1::BaseController
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new show edit update destroy create]

  def index
    @payments = Payment.all
    render json: @payments
  end

  def create
    authorize(Payment)
    @payment = Payment.new(payment_params)
    @payment.project_id = @project.id
    @payment.creator_id = @current_user.id
    if @payment.save
      render_success("Successfully updated the payment", @payment)
    else
      render_errors(@payment)
    end
  end

  def destroy
    @payment.destroy
    render json: { message: "Payment deleted." }
  end

  def update
    authorize(Payment)
    if @payment.update(payment_params)
      render_success("Successfully updated the payment", @payment)
    else
      render_errors(@payment)
    end
  end

  def show
    render json: @payment
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authorize(record, query = nil)
    super([:api, :v1, record], query)
  end
end

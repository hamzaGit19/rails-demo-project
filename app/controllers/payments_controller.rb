# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new show edit update destroy create]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments
  # POST /payments.json
  def create
    authorize User, :is_allowed?, policy_class: PaymentPolicy

    @payment = Payment.new(payment_params)
    @payment.project_id = @project.id
    @payment.creator_id = current_user.id
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update; end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    authorize User, :is_admin?, policy_class: PaymentPolicy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:amount)
  end

  def set_project
    if Project.exists?(id: params[:project_id])
      @project = Project.find(params[:project_id])
    else
      redirect_to dashboard_root_path, notice: "Comment does not exist."
    end
   end
end

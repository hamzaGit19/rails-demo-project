# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new show edit update destroy create]

  def index
    @payments = Payment.all
  end

  def show; end

  def new
    @payment = Payment.new
  end

  def edit; end

  def create
    @payment = Payment.new(payment_params)
    @payment.project_id = @project.id
    @payment.creator_id = current_user.id
  end

  def update; end

  def destroy
    authorize User, :is_admin?, policy_class: PaymentPolicy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_payment
    @payment = Payment.find_by_id(params[:id])
    redirect_to(root_url, notice: 'Record not found') unless @payment
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def set_project
    @project = Project.find_by_id(params[:project_id])
    redirect_to(root_url, notice: 'Record not found') unless @project
  end
end

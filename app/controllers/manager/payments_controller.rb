# frozen_string_literal: true

class Manager::PaymentsController < PaymentsController
  def new
    authorize(Payment)
    super
  end

  def update
    super
    authorize(@payment)
    respond_to do |format|
      if @payment.update(payment_params.except(:employees))
        format.html { redirect_to manager_project_payments_path(@project), notice: "Payment was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    authorize(Payment)
    super
    respond_to do |format|
      if @payment.save
        format.js
        format.html { redirect_to manager_project_payments_path(@project), notice: "Payment was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def show
    authorize(Payment)
    super
  end

  def destroy 
    authorize(Payment)
    super
  end

  def authorize(record, query = nil)
    super([:manager, record], query)
  end
end

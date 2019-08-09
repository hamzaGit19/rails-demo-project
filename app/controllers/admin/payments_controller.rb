# frozen_string_literal: true

class Admin::PaymentsController < PaymentsController
  def new
     authorize(Payment)
    super
  end

  def update
    super
    authorize(@payment)
    respond_to do |format|
      if @payment.update(payment_params.except(:employees))
        format.html { redirect_to admin_project_payments_path(@project), notice: "Payment was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize(@payment)
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_project_payments_path, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def index 
     authorize(Payment)
    super
  end

  def create
    super
    authorize(Payment)
    respond_to do |format|
      if @payment.save
        format.js
        format.html { redirect_to admin_project_payments_path(@project), notice: "Payment was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end

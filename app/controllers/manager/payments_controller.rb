# frozen_string_literal: true

class Manager::PaymentsController < PaymentsController
  def new
    super
  end

  def update
    super
    respond_to do |format|
      if @payment.update(payment_params.except(:employees))
        format.html { redirect_to  manager_project_payments_path(@project), notice: 'Payment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    super
    respond_to do |format|
      if @payment.save
        format.html { redirect_to manager_project_payments_path(@project), notice: 'Payment was successfully created.' }
      else
        format.html { render :new }
       end
    end
  end
end

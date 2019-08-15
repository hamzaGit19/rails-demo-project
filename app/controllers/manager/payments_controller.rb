# frozen_string_literal: true

class Manager::PaymentsController < PaymentsController
  def new
    authorize(Payment)
    super
  end

  def update
    super
    authorize(@payment)

    if @payment.update(payment_params.except(:employees))
      redirect_to manager_project_payments_path(@project), notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def create
    authorize(Payment)
    super

    if @payment.save
    else
      render :new
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

# frozen_string_literal: true

class Admin::PaymentsController < PaymentsController
  def new
    authorize(Payment)
    super
  end

  def update
    super
    authorize(@payment)
    if @payment.update(payment_params.except(:employees))
      redirect_to admin_project_payments_path(@project), notice: 'Payment was successfully updated. '
    else
      render :edit
    end
  end

  def destroy
    authorize(@payment)
    @payment.destroy
    redirect_to admin_project_payments_path, notice: 'Payment was successfully destroyed. '
  end

  def index
    authorize(Payment)
    super
  end

  def create
    super
    authorize(Payment)

    if @payment.save
    else
      render :new
    end
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end

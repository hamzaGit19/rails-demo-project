class Api::V1::Admin::PaymentsController < Api::V1::PaymentsController
  def create
    super
    # authorize(Payment)
    if @payment.save
      render json: @payment
    else
      render json: { message: "Payment failed." }
    end
  end

  def update
    super
    # authorize(@payment)
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: { message: "Payment failed." }
    end
  end
end

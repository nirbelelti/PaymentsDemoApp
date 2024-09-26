require_dependency 'payment_facade'

class Api::V1::PaymentsController < ApplicationController
  def index
    @pagy, payments = pagy(PaymentFacade.all_payments(query_params))
    render json: { payments: payments, metadata: pagy_metadata(@pagy) }
  end

  def show
    render json: PaymentFacade.find_payment(params[:id])
  end

  def create
    payment = PaymentFacade.create_payment(payment_params)
    if payment[:status] == 'success'
      render json: payment, status: :created
    else
      render json: payment, status: :unprocessable_entity
    end
  end

  def refund
    payment = PaymentFacade.refund_payment(payment_params)
    if payment[:status] == 'success'
      render json: payment, status: :created
    else
      render json: payment, status: :unprocessable_entity
    end
  end

  private

  def query_params
    params.permit(:organisation_id)
  end

  def payment_params
    params.permit(:id,
                  :vendor_uuid,
                  :sender_uuid,
                  :receiver_uuid,
                  :amount)
  end
end

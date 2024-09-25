require_dependency 'payment_facade'


class Api::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show update destroy ]

  def index
    @pagy, payments = pagy(PaymentFacade.all_payments(query_params))
    render json: { payments: payments, metadata: pagy_metadata(@pagy) }
  end

  def show
    render json: @payment
  end

  def create
    payment = PaymentFacade.create_payment(payment_params)
    render json: payment, status: :created
  end

  def update
    if PaymentFacade.update_payment(@payment.id, payment_params)
      @payment.reload
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    PaymentFacade.delete_payment(@payment)
  end

  private

  def set_payment
    @payment = PaymentFacade.find_payment(params[:id])
  end

  def query_params
    params.fetch(:query, {}).permit(:organisation_uuid)
  end

  def payment_params
    params.permit(:vendor_uuid,
                  :sender_uuid,
                  :receiver_uuid,
                  :amount)
  end
end

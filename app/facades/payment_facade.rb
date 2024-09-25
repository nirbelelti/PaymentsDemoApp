require 'payment_engine'

class PaymentFacade

  def self.all_payments(query_params = {})
    if query_params && query_params[:organisation_uuid].present?
      Payment.where(organisation_uuid: query_params[:organisation_uuid])
    else
      Payment.all
    end
  end

  def self.find_payment(payment_id)
    Payment.find(payment_id)
  end

  def self.create_payment(payment_params)
    PaymentEngine::PaymentInitiator.initiate_payment(payment_params)
  end

end

require 'payment_engine'

class PaymentFacade

  def self.all_payments(query_params = {})
    PaymentEngine::PaymentQuery.index(query_params)
  end

  def self.refund_payment(payment)
    PaymentEngine::PaymentInitiator.refund_payment(payment)
  end

  def self.find_payment(payment_id)
    PaymentEngine::PaymentQuery.find_payment(payment_id)
  end

  def self.create_payment(payment_params)\
    PaymentEngine::PaymentInitiator.initiate_payment(payment_params)
  end

end

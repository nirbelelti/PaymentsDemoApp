class PaymentFacade

  def self.all_payments(query_params = {})
    if query_params && query_params[:organisation_id].present?
      Payment.where(organisation_id: query_params[:organisation_id])
    else
      Payment.all
    end
  end

  def self.find_payment(payment_id)
    Payment.find(payment_id)
  end
  def self.create_payment(payment_params)
    Payment.create!(payment_params)
  end

  def self.update_payment(payment_id, payment_params)
    payment = Payment.find(payment_id)
    payment.update!(payment_params)
    payment
  end

  def self.delete_payment(payment_id)
    payment = Payment.find(payment_id)
    payment.destroy!
  end
end
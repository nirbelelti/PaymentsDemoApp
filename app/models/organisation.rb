class Organisation < ApplicationRecord
  has_many :payments

  scope :with_last_three_payments, -> {
    organisations_with_payments = includes(:payments).to_a

    organisations_with_payments.map do |org|
      last_three_payments = org.payments.order(created_at: :desc).limit(3)
      last_three_payments_hash = last_three_payments.map do |payment|
        { date: payment.created_at.strftime('%m/%d/%Y'), amount: payment.amount, sender: payment.sender_id, receiver: payment.receiver_id }
      end

      {
        id: org.id,
        name: org.name,
        address: org.address,
        crm_id: org.crm_id,
        segment: org.segment,
        last_payments: last_three_payments_hash.presence || 'No Payments'
      }
    end
  }

  validates :name, presence: true, uniqueness: true, length: { minimum: 2}
  validates :address, presence: true, length: { minimum: 2}
  validates :vat_id, presence: true, length: { minimum: 2}
  validates :crm_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :segment, presence: true

end

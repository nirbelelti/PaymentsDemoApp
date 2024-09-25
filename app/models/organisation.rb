class Organisation < ApplicationRecord
  has_many :payments,  foreign_key: :sender_id, dependent: :destroy
  has_many :payments,  foreign_key: :receiver_id, dependent: :destroy

  scope :with_last_three_payments, -> {
    subquery = Payment.select('payments.*, ROW_NUMBER() OVER (PARTITION BY sender_id ORDER BY payments.created_at DESC) AS row_num')
                      .to_sql

    joins("LEFT JOIN (#{subquery}) AS last_payments ON organisations.id = last_payments.sender_id")
      .where('last_payments.row_num <= 3')
      .select("organisations.*,
            ARRAY_AGG(json_build_object(
              'id', last_payments.id,
              'created_at', last_payments.created_at,
              'amount', last_payments.amount,
              'receiver_id', last_payments.receiver_id
            ) ORDER BY last_payments.created_at DESC) AS last_three_payments")
      .group('organisations.id')
  }

  validates :name, presence: true, uniqueness: true, length: { minimum: 2}
  validates :address, presence: true, length: { minimum: 2}
  validates :vat_id, presence: true, length: { minimum: 2}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :segment, presence: true
  validates :uuid, presence: true, uniqueness: true

end

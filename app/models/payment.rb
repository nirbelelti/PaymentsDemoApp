class Payment < ApplicationRecord
  belongs_to :vendor
  belongs_to :sender, class_name: 'Organisation' , foreign_key: :sender_id
  belongs_to :receiver, class_name: 'Organisation', foreign_key: :receiver_id

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  enum status: { pending: 0, processed: 1, failed: 2, refunded: 3 }

end

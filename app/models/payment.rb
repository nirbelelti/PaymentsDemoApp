class Payment < ApplicationRecord
  include Singleton
  belongs_to :vendor
  belongs_to :sender, class_name: 'Organisation'
  belongs_to :receiver, class_name: 'Organisation'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  enum status: { pending: 0, processed: 1, failed: 2, refunded: 3 }

end

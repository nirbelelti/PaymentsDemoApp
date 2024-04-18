class Payment < ApplicationRecord
  belongs_to :organisation

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

end

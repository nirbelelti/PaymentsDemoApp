# Assumptions: # In the context of payment application, it assume that the vendor is a company that provides services
# to the organisation.

class Vendor < ApplicationRecord

  has_many :payments

  validates :name, presence: true, uniqueness: true, length: { minimum: 2}
  validates :address, presence: true, length: { minimum: 2}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :uuid, presence: true, uniqueness: true
end

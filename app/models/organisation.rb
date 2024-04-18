class Organisation < ApplicationRecord
  has_many :payments

  validates :name, presence: true, uniqueness: true, length: { minimum: 2}
  validates :address, presence: true, length: { minimum: 2}
  validates :vat_id, presence: true, length: { minimum: 2}
  validates :crm_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :segment, presence: true

end

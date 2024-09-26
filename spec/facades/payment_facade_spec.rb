require 'rails_helper'

RSpec.describe PaymentFacade, type: :facade do
  let!(:payments) { FactoryBot.create_list(:payment, 3) }
  let!(:payment) { payments.first }
  let!(:organisations) { FactoryBot.create_list(:organisation, 2) }
  let!(:vendor) { FactoryBot.create(:vendor) }

  describe 'all_payments' do
    it 'returns all payments' do
      expect(described_class.all_payments.to_a).to match_array(payments)
      expect(described_class.all_payments.length).to eq(3)
    end

    it 'filters the results by organisation_id sent on received by' do
      expect(described_class.all_payments(organisation_id: payment.sender_id).length).to eq(Payment.where('sender_id=? or receiver_id =?', payment.sender_id, payment.sender_id).length)
    end
  end

  describe 'find_payment' do
    it 'returns the payment' do
      expect(described_class.find_payment(payment.id)).to eq(payment)
    end
  end

  describe 'create_payment' do
    it 'creates a new payment' do
      payment_params = {vendor_uuid: vendor.uuid,
                        sender_uuid: organisations.first.uuid,
                        receiver_uuid: organisations.last.uuid,
                        amount: 33 }
      expect { described_class.create_payment(payment_params) }.to change(Payment, :count).by(1)
    end
  end

end
require 'rails_helper'

RSpec.describe PaymentFacade, type: :facade do
  let!(:payments) { FactoryBot.create_list(:payment, 3) }
  let!(:payment) { payments.first }
  let(:payment_params) { FactoryBot.attributes_for(:payment, organisation_id: Organisation.first.id  ) }

  describe '.all_payments' do
    it 'returns all payments' do
      expect(described_class.all_payments.to_a).to match_array(payments)
    end
  end

  describe '.find_payment' do
    it 'returns the payment' do
      expect(described_class.find_payment(payment.id)).to eq(payment)
    end
  end

  describe '.create_payment' do
    it 'creates a new payment' do
      expect { described_class.create_payment(payment_params) }.to change(Payment, :count).by(1)
    end
  end

  describe '.update_payment' do
    it 'updates the payment' do
      described_class.update_payment(payment.id, payment_params)
      payment.reload
      expect(payment.amount).to eq(payment_params[:amount])
    end
  end

  describe '.delete_payment' do
    it 'deletes the payment' do
      described_class.delete_payment(payment.id)
      expect(Payment.exists?(payment.id)).to be_falsey
    end
  end
end
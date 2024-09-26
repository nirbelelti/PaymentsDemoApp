require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let!(:organisation) { FactoryBot.create(:organisation) }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:vat_id) }
    it { should validate_presence_of(:crm_id) }
    it { should validate_presence_of(:email) }
    it do
      should allow_value('test@example.com').for(:email)
      should_not allow_value('invalid_email').for(:email)
    end
  end

  describe 'Associations' do
    it { should have_many(:received_payments) }
    it { should have_many(:sent_payments) }
  end

  describe 'Scopes' do

    describe 'with_last_three_payments' do

      4.times do |i|
        let!("payment#{i + 1}") { FactoryBot.create(:payment, created_at: i.days.ago, organisation: organisation) }
      end

      it 'returns organisations with their last three payments' do
        result = Organisation.with_last_three_payments
        expect(result.size).to eq(1)

        organisation_data = result.first
        expect(organisation_data[:id]).to eq(organisation.id)
        expect(organisation_data[:name]).to eq(organisation.name)
        expect(organisation_data[:address]).to eq(organisation.address)

        last_payments = organisation_data[:last_payments]
        expect(last_payments.size).to eq(3)
        expect(last_payments).to include(
                                   { date: payment1.created_at.strftime('%m/%d/%Y'), amount: payment1.amount, sender: payment1.sender_id, receiver: payment1.receiver_id },
                                   { date: payment2.created_at.strftime('%m/%d/%Y'), amount: payment2.amount, sender: payment2.sender_id, receiver: payment2.receiver_id },
                                   { date: payment3.created_at.strftime('%m/%d/%Y'), amount: payment3.amount, sender: payment3.sender_id, receiver: payment3.receiver_id }
                                 )
        expect(last_payments).not_to include({ date: payment4.created_at.strftime('%m/%d/%Y'), amount: payment4.amount, sender: payment4.sender_id, receiver: payment4.receiver_id })
      end
    end
  end
end
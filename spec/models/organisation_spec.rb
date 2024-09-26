require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let!(:organisation) { FactoryBot.create(:organisation) }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:vat_id) }
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
        let!("payment#{i + 1}") { FactoryBot.create(:payment, created_at: i.days.ago, sender_id: organisation.id) }
      end

      it 'returns organisations with their last three payments' do
        count = 0
        Organisation.with_last_three_payments.each do |organisation|
          organisation.last_three_payments.each do |payment|
            count += 1
            expect(payment["id"]).to be_present
            expect(payment["created_at"]).to be_present
            expect(payment["amount"]).to be_present
            expect(payment["receiver_id"]).to be_present
          end
          expect(organisation.last_three_payments.size).to eq(3)
        end
        expect(count).to eq(3)
      end
    end
  end
end
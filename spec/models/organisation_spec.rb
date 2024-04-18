require 'rails_helper'

RSpec.describe Organisation, type: :model do

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
    it { should have_many(:payments) }
  end
end
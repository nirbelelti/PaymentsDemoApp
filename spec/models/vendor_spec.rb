require 'rails_helper'

RSpec.describe Vendor, type: :model do

  describe 'Associations' do
    it { should have_many(:payments) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:uuid) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
  end

end

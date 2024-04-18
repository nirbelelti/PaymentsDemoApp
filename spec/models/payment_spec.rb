require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe "Validation" do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:sender_id) }
    it { should validate_presence_of(:receiver_id) }
  end

  describe "Associations" do
    it { should belong_to(:organisation) }
  end
end

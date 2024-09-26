FactoryBot.define do
  factory :payment do
    amount { Faker::Commerce.price(range: 100.0..1000.0) }
    sender_id {FactoryBot.create(:organisation).id }
    receiver_id { FactoryBot.create(:organisation).id }
    vendor
  end
end
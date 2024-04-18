FactoryBot.define do
  factory :payment do
    amount { Faker::Commerce.price(range: 100.0..1000.0) }
    sender_id { Faker::Number.unique.number(digits: 5) }
    receiver_id { Faker::Number.unique.number(digits: 5) }
    organisation
  end
end
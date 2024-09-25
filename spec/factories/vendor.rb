FactoryBot.define do
  factory :vendor do
    name { Faker::Company.unique.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.unique.email }
    uuid { SecureRandom.uuid }
  end
end
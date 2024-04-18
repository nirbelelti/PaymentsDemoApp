FactoryBot.define do
  factory :organisation do
    name { Faker::Company.unique.name }
    address { Faker::Address.street_address }
    vat_id { Faker::Number.unique.number(digits: 10) }
    crm_id { Faker::Number.unique.number(digits: 10) }
    email { Faker::Internet.unique.email }
    segment { Faker::Commerce.department }
  end
end
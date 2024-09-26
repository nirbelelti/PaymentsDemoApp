FactoryBot.define do
  factory :organisation do
    name { Faker::Company.unique.name }
    address { Faker::Address.street_address }
    vat_id { Faker::Number.unique.number(digits: 10) }
    email { Faker::Internet.unique.email }
    segment { Faker::Commerce.department }
    country { Faker::Address.country }
    province { Faker::Address.state }
    zip { Faker::Address.zip_code }
    uuid { SecureRandom.uuid }
    balance { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
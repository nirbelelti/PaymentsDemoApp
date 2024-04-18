# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  if Organisation.count == 0
    5.times do
      Organisation.create!(
        name: Faker::Company.unique.name,
        address: Faker::Address.street_address,
        vat_id: Faker::Number.unique.number(digits: 10),
        crm_id: Faker::Number.unique.number(digits: 10),
        email: Faker::Internet.unique.email,
        segment: Faker::Commerce.department
      )
    end
  end
  if Payment.count == 0
    20.times do
      Payment.create!(
        amount: rand(100.0..1000.0),
        sender_id: Faker::Number.unique.number(digits: 5),
        receiver_id: Faker::Number.unique.number(digits: 5),
        organisation_id: Organisation.order('RANDOM()').first.id
      )
    end
  end

end

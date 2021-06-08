FactoryBot.define do
  factory :purchase_log_address do
    transient do
      digitpn { 11 }
    end
    address = Gimei.address
    token { Faker::Lorem.characters }
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { address.city.kanji }
    house_number { address.town.kanji + Faker::Address.building_number }
    building_name { Faker::Lorem.word }
    phone_number { Faker::Number.number(digits: digitpn) }
  end
end

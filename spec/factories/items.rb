FactoryBot.define do
  factory :item do
    transient do
      name_number { 40 }
      description_number { 1000 }
    end

    name { Faker::Lorem.characters(number: name_number) }
    description { Faker::Lorem.paragraph_by_chars(number: description_number) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    charge_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    day_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test1.png'), filename: 'test1.png')
    end
  end
end

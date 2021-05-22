FactoryBot.define do
  factory :user do
    person=Gimei.name
    nickname {Faker::FunnyName.name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 4)+"1a"}
    password_confirmation {password}
    last_name {person.last.kanji}
    first_name {person.first.kanji}
    last_name_kana {person.last.katakana}
    first_name_kana {person.first.katakana}
    birth_date {Faker::Date.between(from: "1930-1-1", to: "2016-12-31")}
  end
end

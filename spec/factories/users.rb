FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { "虹" }
    last_name             { "星" }
    read_first            {"トモ"}
    read_last             {"マエ"}
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
end
end

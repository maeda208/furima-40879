FactoryBot.define do
  factory :order_address do
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id         { Faker::Number.between(from: 2, to: 48) }
    municipalities        { Faker::Name.initials }
    address               { Faker::Name.initials }
    building_name         { Faker::Name.initials }
    phone_number          { Faker::Number.between(from: 0o000000000, to: 99_999_999_999) }
    token                 { 42_424_242_424_242_421_125_123 }
    
  end
end

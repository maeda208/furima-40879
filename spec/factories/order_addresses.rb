FactoryBot.define do
  factory :order_address do
     post_code             {  "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"  }
    prefecture_id         { Faker::Number.between(from: 2, to: 48) }
    municipalities        { Faker::Name.initials }
    address               { Faker::Name.initials }
    building_name         { Faker::Name.initials }
    phone_number          { Faker::Number.between(from: 0000000000, to: 99999999999) }
    token                 { 42424242424242421125123 }
    user_id {1}
    item_id {21}
  
  end
end

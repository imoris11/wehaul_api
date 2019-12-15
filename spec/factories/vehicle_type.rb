FactoryBot.define do
  factory :vehicle_type do
    name {Faker::Name.first_name}
    description {Faker::Lorem.sentence}
    max_price_per_km {100}
    min_price_per_km {30}
  end
end
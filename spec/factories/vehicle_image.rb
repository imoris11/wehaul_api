FactoryBot.define do
  factory :vehicle_image do
    image {Faker::Avatar.image}
  end
end
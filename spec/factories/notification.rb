FactoryBot.define do
  factory :notification do
    target {Faker::Name.first_name}
    message {Faker::Lorem.sentence}
    user {nil}
    is_read {false}
  end
end
FactoryBot.define do
  factory :support_ticket do
    user_id {nil}
    trip_request_id {nil}
    content {Faker::Lorem.paragraph}
    topic {Faker::Lorem.sentence}
  end
end
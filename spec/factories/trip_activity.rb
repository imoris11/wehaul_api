FactoryBot.define do
  factory :trip_activity do
    user_id {nil}
    trip_request_id {nil}
    activity {Faker::Lorem.word}
  end
end
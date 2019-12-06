FactoryBot.define do
    factory :schedule do
        title {Faker::Lorem.sentence}
        date_time {Time.now}
        header_photo {Faker::Avatar.image}
        user_id {nil}
    end
end
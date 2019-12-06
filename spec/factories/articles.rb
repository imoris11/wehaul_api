FactoryBot.define do
    factory :article do
        title { Faker::Lorem.sentence }
        content { Faker::Lorem.paragraph }
        header_photo {Faker::Lorem.word}
        category_id {nil}
        user_id {nil}
        views {0}
        token {nil}
        photo_caption {Faker::Lorem.sentence}
    end
end
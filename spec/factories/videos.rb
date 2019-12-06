FactoryBot.define do
    factory :video do
      title {Faker::Lorem.word}
      user_id {nil}
      category_id {nil}
      views {0}
      video_url {Faker::Lorem.word}
      token {nil}
      header_photo {Faker::Lorem.word}
    end
  end
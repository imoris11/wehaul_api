FactoryBot.define do
    factory :category do
        title {Faker::Lorem.word}
        token {nil}
    end
end
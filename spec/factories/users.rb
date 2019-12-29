FactoryBot.define do
    factory :user do
        name { Faker::Name.first_name }
        role {'admin'}
        email {Faker::Internet.email }
        password {"foobar"}
        token {nil}
    end
end
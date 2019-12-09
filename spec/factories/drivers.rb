FactoryBot.define do
    factory :driver do
        name {Faker::Name.first_name}
        phone_number {'123456789'} 
        resident_state {'Bayelsa'} 
        vehicle_license_number {'abc1234'} 
        drivers_license {'123abc'}
        token {nil}
        email {Faker::Internet.email}
        password {'foobar'}
    end
end
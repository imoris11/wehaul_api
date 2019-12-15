FactoryBot.define do
  factory :vehicle do
    plate_number {Faker::Lorem.word}
    license {Faker::Avatar.image}
    license_no {Faker::Lorem.word}
    serial_no {Faker::Lorem.word}
    license_issue_date {Time.now - 30.days}
    license_expiry_date {Time.now + 50.days}
  end
end
FactoryBot.define do
  factory :driver_request do
    has_responded {true}
    is_accepted {false}
    price {1300}
  end
end
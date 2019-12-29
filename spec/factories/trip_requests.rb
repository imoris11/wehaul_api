FactoryBot.define do
  factory :trip_request do
    fee {1200}
    weight {10}
    pickup_time {'10AM'}
    pickup_date {Time.now}
    destination_address {"Yenagoa, Bayelsa State"}
    pickup_address {"Gbagada, Lagos"}
    quantity {5}
    driver_id {1}
    commission {50}
    driver_fee {2000}
    token {nil}
  end
end
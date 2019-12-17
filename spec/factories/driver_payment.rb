FactoryBot.define do
  factory :driver_payment do
    paid_by {"Richard Igbiriki"}
    is_paid {true}
    amount {300}
    has_responded {true}
  end
end
FactoryBot.define do
  factory :payment_transaction do
    user_id {nil}
    medium {'wallet'}
    amount {1000}
    transaction_ref {'xsRfefsd'}
  end
end
FactoryBot.define do
  factory :payment_transaction do
    user_id {nil}
    medium {'wallet'}
    amount {1000}
    message {"A test deposit"}
    deposit_type {'Wallet update'}
    transaction_ref {'xsRfefsd'}
  end
end
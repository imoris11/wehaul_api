FactoryBot.define do
  factory :wallet do
    user_id {nil}
    created_by {nil}
    amount {1000}
    source {'card'}
    deposit_type {'credit'}
    payment_reference {'xyref'}
  end
end
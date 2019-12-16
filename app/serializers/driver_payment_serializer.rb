class DriverPaymentSerializer < ActiveModel::Serializer
  attributes :id, :created_by, :paid_by, :is_paid, :amount, :has_responded, :token
  has_one :user
  has_one :trip_request
end

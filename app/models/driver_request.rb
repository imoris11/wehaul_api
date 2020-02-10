class DriverRequest < ApplicationRecord
  include Tokenable
  belongs_to :user
  belongs_to :trip_request
  default_scope {order('created_at DESC')}
  validates_presence_of :price

  def self.accepted
    self.where(is_accepted: true)
  end
end

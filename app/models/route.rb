class Route < ApplicationRecord
  include Tokenable
  validates_presence_of :from, :to
  default_scope {order('created_at DESC')}
end

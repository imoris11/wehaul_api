class Route < ApplicationRecord
  include Tokenable
  validates_presence_of :from, :to
end

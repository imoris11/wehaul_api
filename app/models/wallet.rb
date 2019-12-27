class Wallet < ApplicationRecord
  include Tokenable
  belongs_to :user
end

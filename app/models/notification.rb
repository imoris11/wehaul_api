class Notification < ApplicationRecord
  include Tokenable
  belongs_to :user

  validates_presence_of :target, :message
end

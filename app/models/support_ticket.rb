class SupportTicket < ApplicationRecord
  include Tokenable
  belongs_to :user
  belongs_to :trip_request

  validates_presence_of :content, :topic
end

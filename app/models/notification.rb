class Notification < ApplicationRecord
  include Tokenable
  belongs_to :user
  default_scope {order('created_at DESC')}
  validates_presence_of :target, :message

end

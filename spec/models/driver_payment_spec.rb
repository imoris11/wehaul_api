require 'rails_helper'

RSpec.describe DriverPayment, type: :model do
  it {should belong_to(:user) }
  it { should belong_to(:trip_request) }

  it { should validate_presence_of(:amount)}
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:profile).dependent(:destroy) }
  it { should have_one(:wallet).dependent(:destroy) }
  it { should have_many(:trip_activities).dependent(:destroy) }
  it { should have_many(:trip_requests).dependent(:destroy) }
  it { should have_many(:vehicles).dependent(:destroy) }
  it { should have_many(:driver_requests).dependent(:destroy) }
  it { should have_many(:driver_payments).dependent(:destroy) }
  it { should have_many(:payment_transactions).dependent(:destroy) }
  it { should have_many(:support_tickets).dependent(:destroy) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end

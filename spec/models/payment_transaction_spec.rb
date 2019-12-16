require 'rails_helper'

RSpec.describe PaymentTransaction, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:medium) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:transaction_ref) }
end

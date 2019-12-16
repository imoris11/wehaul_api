require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:created_by)}
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:payment_reference)}
end

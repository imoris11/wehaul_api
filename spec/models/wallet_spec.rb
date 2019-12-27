require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it { should belong_to(:user) }
end

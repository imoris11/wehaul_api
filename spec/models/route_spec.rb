require 'rails_helper'

RSpec.describe Route, type: :model do
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
end

require 'rails_helper'

RSpec.describe VehicleType, type: :model do
  it { should have_many(:vehicle).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:max_price_per_km) }
  it { should validate_presence_of(:min_price_per_km) }
end

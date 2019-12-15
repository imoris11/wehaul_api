require 'rails_helper'

RSpec.describe VehicleImage, type: :model do
  it { should belong_to(:vehicle) }

  it { should validate_presence_of(:image) }
end

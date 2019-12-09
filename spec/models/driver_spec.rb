require 'rails_helper'

RSpec.describe Driver, type: :model do
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:resident_state) }
  it { should validate_presence_of(:drivers_license) }
  it { should validate_presence_of(:vehicle_license_number) }

end

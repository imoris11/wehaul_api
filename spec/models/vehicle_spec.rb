require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  #validate relationships
  it { should belong_to(:user) }
  it { should belong_to(:vehicle_type) }
  it { should have_many(:vehicle_image) }

  #validate presence of required data
  it { should validate_presence_of(:plate_number) }
  it { should validate_presence_of(:license) }
  it { should validate_presence_of(:license_no) }
  #it { should validate_presence_of(:serial_no) }
  it { should validate_presence_of(:license_expiry_date) }
  it { should validate_presence_of(:license_issue_date) }
end

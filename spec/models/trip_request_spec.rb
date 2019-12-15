require 'rails_helper'

RSpec.describe TripRequest, type: :model do
  #validate relationships
 it { should belong_to(:user) }
 it { should belong_to(:vehicle_type) }

 #validate presence of necessary data
 it { should validate_presence_of(:fee) }
 it { should validate_presence_of(:weight) }
 it { should validate_presence_of(:pickup_time) }
 it { should validate_presence_of(:pickup_date) }
 it { should validate_presence_of(:quantity) }

end

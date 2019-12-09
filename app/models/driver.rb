class Driver < ApplicationRecord
    include Tokenable
    has_secure_password

    validates_presence_of :name, :phone_number, :resident_state, :vehicle_license_number, :drivers_license
end

class Admins::DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :ban, :busy, :update_profile, :vehicles, :trips]
  before_action :set_trip, only: [:trip_drivers]

  def index
    drivers = User.driver.paginate(page:params[:page], per_page:20).map(&:attributes)
    drivers = add_driver_trips(drivers)
    json_response(drivers)
  end

  def show
   user = @driver
   profile = @driver.profile
   response = {user: user, profile: profile}
   json_response(response)
  end

  def vehicles 
    vehicle = @driver.vehicle
    json_response(vehicle)
  end

  def trips 
    trips =TripRequest.where('driver_id=?', @driver.id)
    json_response(trips)
  end

  def update
    @driver.update!(driver_params)
    json_response(@driver)
  end

  def create 
    user = User.create!({name:params[:name], email: params[:email], role:'driver', user_type:'driver', password: 'Password1234', password_confirmation: 'Password1234', phone_number: params[:phone_number]})
     UserNotifierMailer.send_added_email(user).deliver
    vehicle = Vehicle.new(vehicle_params)
    vehicle.user_id = user.id
    vehicle_type = VehicleType.find_by_name!(params[:vehicle_type])
    vehicle.vehicle_type_id = vehicle_type.id 
    vehicle.save!
    params[:vehicle_images].each do |link|
      vehicle.vehicle_images.create!({image: link})
    end
    user.profile.update!(update_params)
    json_response(user, :created)
  end

  def update_profile 
    @driver.profile.update!(update_params)
    json_response(@driver)
  end


  def ban
    if  @driver.banned? 
      @driver.status = "active"
    else
      @driver.status = "banned"
    end
    @driver.save!
    json_response(@driver)
  end

  def busy
    if @driver.busy? 
      @driver.status = "active"
    else
      @driver.status = "busy"
    end
    @driver.save!
    json_response(@driver)
  end

  def stats
    all = User.driver.count
    busy = User.driver.busy.count
    banned = User.driver.banned.count
    available = all - busy - banned
    response = { all: all, busy: busy, banned: banned, available: available } 
    json_response(response)
  end

  def driver_information
    driver = User.find(params[:id])
    json_response(driver)
  end

  def trip_drivers
    drivers = get_active_drivers(@trip)
    json_response(drivers)
  end

  private 

  def set_driver
    @driver = User.find_by_token!(params[:id])
  end

  def set_trip
    @trip = TripRequest.find_by_token!(params[:id])
  end

  def add_driver_trips(drivers)
    res=[]
    drivers.each do |driver|
      completed = TripRequest.where('driver_id=?', driver['id']).completed.count
      trips = TripRequest.where('driver_id=?', driver['id']).count
      driver['completed'] = completed
      driver['trips'] = trips
      driver['profile'] = Profile.find_by_user_id(driver['id'])
      res<<driver
    end
    return res
  end

   # Only allow a trusted parameter "white list" through.
   def driver_params
    params.permit(:name, :email, :role, :phone_number, :user_type)
  end

  def update_params 
    params.permit(:address, :resident_state, :city, :country,  :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date, :driver_license_issue_date, :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name, :vehicle_type, :gender, :company_name)
  end

  def vehicle_params
    params.permit(:plate_number, :license, :license_no, :license_issue_date, :license_expiry_date, :vehicle_type_id)
  end
end

class Admins::DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :ban, :busy, :update_profile]
  def index
    drivers = User.driver.paginate(page:params[:page], per_page:20)
    json_response(drivers)
  end

  def show
    json_response(@driver)
  end

  def update
    @driver.update!(driver_params)
    json_response(@driver)
  end

  def update_profile 
    @driver.profile.update!(update_params)
    json_response(@driver)
  end


  def ban
    @driver.banned = !@driver.banned
    @driver.save!
    json_response(@driver)
  end

  def busy
    @driver.busy = !@driver.busy
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

  private 
  def set_driver
    @driver = User.find_by_token!(params[:id])
  end

   # Only allow a trusted parameter "white list" through.
   def driver_params
    params.permit(:name, :email, :role, :phone_number, :user_type)
  end

  def update_params 
    params.permit(:address, :resident_state, :city, :country,  :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date,   :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name)
  end
end

class Drivers::DriversController < Drivers::BaseController
  skip_before_action :authorize_request, only: :create
  before_action :set_driver, only: [:show, :update, :destroy]

  # GET /drivers
  def index
    @drivers = Driver.all
    json_response(@drivers)
  end

  # GET /drivers/1
  def show
    json_response(@driver)
  end

  # POST /drivers
  def create
    @driver = Driver.create!(driver_params)
    auth_token = AuthenticateDriver.new( @driver.phone_number, @driver.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # PATCH/PUT /drivers/1
  def update
    @driver.update!(driver_params)
    json_response(@driver)
   
  end

  # DELETE /drivers/1
  def destroy
    @driver.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_params
      params.permit(:name, :email, :address, :phone_number, :vehicle_type, :resident_state, :vehicle_number, :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date, :vehicle_license_number, :vehicle_license_number_expiry, :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name, :password, :password_confirmation, :token)
    end
end

class DriverRoutesController < ApplicationController
  before_action :set_driver_route, only: [:show, :update, :destroy]
  before_action :set_driver, only: [:create_routes, :driver_routes]


  # GET /driver_routes/1
  def show
   json_response(@driver_route)
  end

  # POST /driver_routes
  def create_routes
    routes = []
    params[:routes].each do |route|
      @driver_route = @driver.driver_routes.create!({location: route})
      routes<<@driver_route
    end
    json_response({routes:routes}, :created)
  end

  def driver_routes
    @driver_routes = @driver.driver_routes.all
    json_response(@driver_routes)
  end

  # PATCH/PUT /driver_routes/1
  def update
     @driver_route.update!(driver_route_params)
     json_response(@driver_route)
  end

  # DELETE /driver_routes/1
  def destroy
    @driver_route.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_route
      @driver_route = DriverRoute.find_by_token!(params[:id])
    end

    def set_driver
      @driver = User.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_route_params
      params.permit(:user_id, :location)
    end
end

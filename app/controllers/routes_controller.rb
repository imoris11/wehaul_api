class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.all.paginate(page:params[:page], per_page:20)
    json_response(@routes)
  end

  # GET /routes/1
  def show
    json_response(@route)
  end

  def stats 
    routes = Route.all.count
    drivers = User.driver.count
    vehicles = VehicleType.all.count 
    requests = TripRequest.requests.count
    response ={ routes:routes, drivers:drivers, vehicles: vehicles, requests: requests}
    json_response(response)
  end

  # POST /routes
  def create
    @route = Route.create!(route_params)
    json_response(@route, :created)
  end

  # PATCH/PUT /routes/1
  def update
    @route.update!(route_params)
    json_response(@route)
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_params
      params.permit(:from, :to)
    end
end

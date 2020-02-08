require 'rails_helper'

RSpec.describe "DriverRoutes", type: :request do
  describe "GET /driver_routes" do
    it "works! (now write some real specs)" do
      get driver_routes_path
      expect(response).to have_http_status(200)
    end
  end
end

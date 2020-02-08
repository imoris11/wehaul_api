require "rails_helper"

RSpec.describe DriverRoutesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/driver_routes").to route_to("driver_routes#index")
    end

    it "routes to #show" do
      expect(:get => "/driver_routes/1").to route_to("driver_routes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/driver_routes").to route_to("driver_routes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/driver_routes/1").to route_to("driver_routes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/driver_routes/1").to route_to("driver_routes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/driver_routes/1").to route_to("driver_routes#destroy", :id => "1")
    end
  end
end

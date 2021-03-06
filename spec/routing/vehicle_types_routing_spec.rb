require "rails_helper"

RSpec.describe VehicleTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/vehicle_types").to route_to("vehicle_types#index")
    end

    it "routes to #show" do
      expect(:get => "/vehicle_types/1").to route_to("vehicle_types#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/vehicle_types").to route_to("vehicle_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/vehicle_types/1").to route_to("vehicle_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/vehicle_types/1").to route_to("vehicle_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vehicle_types/1").to route_to("vehicle_types#destroy", :id => "1")
    end
  end
end

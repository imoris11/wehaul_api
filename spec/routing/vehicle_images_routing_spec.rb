require "rails_helper"

RSpec.describe VehicleImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/vehicle_images").to route_to("vehicle_images#index")
    end

    it "routes to #show" do
      expect(:get => "/vehicle_images/1").to route_to("vehicle_images#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/vehicle_images").to route_to("vehicle_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/vehicle_images/1").to route_to("vehicle_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/vehicle_images/1").to route_to("vehicle_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vehicle_images/1").to route_to("vehicle_images#destroy", :id => "1")
    end
  end
end

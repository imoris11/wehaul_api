require "rails_helper"

RSpec.describe TripRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/trip_requests").to route_to("trip_requests#index")
    end

    it "routes to #show" do
      expect(:get => "/trip_requests/1").to route_to("trip_requests#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/trip_requests").to route_to("trip_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trip_requests/1").to route_to("trip_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trip_requests/1").to route_to("trip_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trip_requests/1").to route_to("trip_requests#destroy", :id => "1")
    end
  end
end

require "rails_helper"

RSpec.describe TripActivitiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/trip_activities").to route_to("trip_activities#index")
    end

    it "routes to #show" do
      expect(:get => "/trip_activities/1").to route_to("trip_activities#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/trip_activities").to route_to("trip_activities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trip_activities/1").to route_to("trip_activities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trip_activities/1").to route_to("trip_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trip_activities/1").to route_to("trip_activities#destroy", :id => "1")
    end
  end
end

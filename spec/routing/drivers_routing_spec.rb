require "rails_helper"

RSpec.describe Drivers::DriversController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/drivers/drivers").to route_to("drivers/drivers#index")
    end

    it "routes to #show" do
      expect(:get => "/drivers/drivers/1").to route_to("drivers/drivers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/drivers/drivers").to route_to("drivers/drivers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/drivers/drivers/1").to route_to("drivers/drivers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/drivers/drivers/1").to route_to("drivers/drivers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/drivers/drivers/1").to route_to("drivers/drivers#destroy", :id => "1")
    end
  end
end

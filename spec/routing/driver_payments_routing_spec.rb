require "rails_helper"

RSpec.describe DriverPaymentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/driver_payments").to route_to("driver_payments#index")
    end

    it "routes to #show" do
      expect(:get => "/driver_payments/1").to route_to("driver_payments#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/driver_payments").to route_to("driver_payments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/driver_payments/1").to route_to("driver_payments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/driver_payments/1").to route_to("driver_payments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/driver_payments/1").to route_to("driver_payments#destroy", :id => "1")
    end
  end
end

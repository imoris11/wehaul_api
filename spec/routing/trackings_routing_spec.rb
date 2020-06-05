require "rails_helper"

RSpec.describe TrackingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/trackings").to route_to("trackings#index")
    end

    it "routes to #show" do
      expect(:get => "/trackings/1").to route_to("trackings#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/trackings").to route_to("trackings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trackings/1").to route_to("trackings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trackings/1").to route_to("trackings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trackings/1").to route_to("trackings#destroy", :id => "1")
    end
  end
end

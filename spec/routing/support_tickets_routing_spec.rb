require "rails_helper"

RSpec.describe SupportTicketsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/support_tickets").to route_to("support_tickets#index")
    end

    it "routes to #show" do
      expect(:get => "/support_tickets/1").to route_to("support_tickets#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/support_tickets").to route_to("support_tickets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/support_tickets/1").to route_to("support_tickets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/support_tickets/1").to route_to("support_tickets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/support_tickets/1").to route_to("support_tickets#destroy", :id => "1")
    end
  end
end

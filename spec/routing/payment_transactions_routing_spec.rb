require "rails_helper"

RSpec.describe PaymentTransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/payment_transactions").to route_to("payment_transactions#index")
    end

    it "routes to #show" do
      expect(:get => "/payment_transactions/1").to route_to("payment_transactions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/payment_transactions").to route_to("payment_transactions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/payment_transactions/1").to route_to("payment_transactions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/payment_transactions/1").to route_to("payment_transactions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/payment_transactions/1").to route_to("payment_transactions#destroy", :id => "1")
    end
  end
end

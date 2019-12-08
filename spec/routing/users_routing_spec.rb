require "rails_helper"

RSpec.describe Customers::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/customers/users").to route_to("customers/users#index")
    end

    it "routes to #show" do
      expect(:get => "/customers/users/1").to route_to("customers/users#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/customers/users").to route_to("customers/users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/customers/users/1").to route_to("customers/users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/customers/users/1").to route_to("customers/users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/customers/users/1").to route_to("customers/users#destroy", :id => "1")
    end
  end
end

require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let!(:user){ create(:user) }
  let!(:vehicle){ create(:vehicle_type) }
  let!(:requests){ create_list(:trip_request, 10, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:nil, created_by:user.id)}
  let(:request_id){requests.first.token}
  let(:headers){valid_headers}

  describe "GET requests" do
    before {get "/admins/accounts", headers:headers }
    context "when it works" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
  
      it "returns 10 items" do
        expect(json.size).to eq(10)
      end
    end
  end

  describe "GET /trip_requests/:token" do
    before { get "/admins/accounts/stats", headers:headers}
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a valid request" do
        expect(json['active']).to eq(0)
      end

  end

  
end

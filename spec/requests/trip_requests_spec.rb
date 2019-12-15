require 'rails_helper'

RSpec.describe "TripRequests", type: :request do
  let!(:user){ create(:user) }
  let!(:vehicle){ create(:vehicle_type) }
  let!(:requests){ create_list(:trip_request, 10, user_id: user.id, vehicle_type_id: vehicle.id)}
  let(:request_id){requests.first.token}
  let(:headers){valid_headers}

  describe "GET /trip_requests" do
    before {get "/trip_requests", headers:headers }
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
    before { get "/trip_requests/#{request_id}", headers:headers}

    context "when token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a valid request" do
        expect(json['token']).to eq(request_id)
      end
    end

    context "when token is invalid" do
      let(:request_id){100}
      before {get  "/trip_requests/#{request_id}", headers:headers }
      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /trip_requests" do
    let(:params){{fee:1000, vehicle_type_id:vehicle.id, weight:20, pickup_time: '12PM', pickup_date:Time.now, quantity:5, commission:240}.to_json}
    context "when it is a valid request" do
      before {post "/trip_requests", params: params, headers:headers}
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end

      it "returns a valid, matching request" do
        expect(json['fee']).to eq(1000)
      end
    end

    context "when it is an invalid request" do
      let(:params){{fee:1000, weight:20, pickup_time: '12PM', vehicle_type_id:vehicle.id}.to_json}
      before {post "/trip_requests", params:params, headers:headers}
      it "returns a 422 error code" do
        expect(response).to have_http_status(422)
      end

      it "returns an erro message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /trip_requests/:token" do
    let(:params){{fee:1200, weight:250}.to_json}
    before {put "/trip_requests/#{request_id}", params:params, headers:headers}

    context "when it is a valid update request" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a matching request" do
        expect(json['fee']).to eq(1200)
      end
    end
  end

  describe "DELETE /trip_requests/:token" do
    before {delete "/trip_requests/#{request_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

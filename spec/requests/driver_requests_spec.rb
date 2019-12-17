require 'rails_helper'

RSpec.describe "DriverRequests", type: :request do
  let(:user){create(:user)}
  let!(:vehicle){ create(:vehicle_type) }
  let!(:trip){create(:trip_request, user_id:user.id, vehicle_type_id:vehicle.id)}
  let!(:driver_requests){create_list(:driver_request, 10, user_id:user.id, trip_request_id:trip.id, created_by:user.id )}
  let(:request_id){driver_requests.first.token}
  let(:headers){valid_headers}

  describe "GET /driver_requests" do
    before {get "/driver_requests", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
    it "returns 10 requests" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /driver_requests/:token" do
    context "when the token is valid" do
      before {get "/driver_requests/#{request_id}", headers:headers}
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns a matching request" do
        expect(json['token']).to eq(request_id)
      end
    end

    context "when the token is invalid" do
      let(:request_id){140}
      before {get "/driver_requests/#{request_id}", headers:headers}
      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "expects a not found error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
    
    
  end

  describe "POST /driver_requests" do
    context "when the request is valid" do
      let(:params){{price:1000, has_responded:false, user_id:user.id, trip_request_id:trip.id, created_by:user.id }.to_json}
      before {post "/driver_requests", params:params, headers:headers}
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end

      it "returns a matching request" do
        expect(json['price']).to eq(1000)
      end
    end

    context "when the request is invalid" do
      let(:params){{price:1000, has_responded:false, user_id:user.id}.to_json}
      before {post "/driver_requests", params:params, headers:headers}

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
    
  end

  describe "PUT /driver_requests/:token" do
    let(:params){{price:900}.to_json}
    before {put "/driver_requests/#{request_id}", params:params, headers:headers}

    it "returns a 200 status" do
      expect(response).to have_http_status(200)
    end

    it "returns an accurate request" do
      expect(json['price']).to eq(900)
    end
  end

  describe "DELETE /driver_requests/:token" do
    before {delete "/driver_requests/#{request_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end
end

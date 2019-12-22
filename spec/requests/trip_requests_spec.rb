require 'rails_helper'

RSpec.describe "TripRequests", type: :request do
  let!(:user){ create(:user) }
  let!(:vehicle){ create(:vehicle_type) }
  let!(:requests){ create_list(:trip_request, 10, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:nil)}
  let!(:trips){ create_list(:trip_request, 15, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:user.id)}
  let(:request_id){requests.first.token}
  let(:headers){valid_headers}

  describe "GET requests" do
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
    let(:params){{fee:1200, weight:250, status:'completed'}.to_json}
    before {put "/trip_requests/#{request_id}", params:params, headers:headers}

    context "when it is a valid update request" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a matching request" do
        expect(json['fee']).to eq(1200)
      end

      it "returns a completed request" do
        expect(json['status']).to eq('completed')
      end
    end
  end

  describe "DELETE /trip_requests/:token" do
    before {delete "/trip_requests/#{request_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

  describe "GET stats for requests" do
    before {get "/trip_requests/request_stats", headers:headers}

    it "should return a 200 status" do
      expect(response).to have_http_status(200)
    end

    it "should have 10 active requests" do
      expect(json['active']).to eq(10)
    end

    it "should have 0 completed, cancelled" do
      expect(json['completed']).to eq(0)
    end

    it "should have 0 completed, cancelled" do
      expect(json['cancelled']).to eq(0)
    end

  end

  describe "GET trips" do
    before{ get "/trip_requests/trips", headers:headers }
    
    it "should return a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "should return 15 items" do
      expect(json.size).to eq(15)
    end

  end

  describe "GET stats for trips" do
    before {get "/trip_requests/trips_stats", headers: headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 15 active trips" do
      expect(json['active']).to eq(15)
    end

    it "returns 0 completed" do
      expect(json['completed']).to eq(0)
    end

    it "returns all trips" do
      expect(json['all']).to eq(15)
    end
  end

  describe "GET cancelled requests" do
    before { get "/trip_requests/cancelled_requests", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 0 requests" do
      expect(json.size).to eq(0)
    end
  end

  describe "GET active requests" do
    before { get "/trip_requests/active_requests", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 requests" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET completed trips" do
    context "when there are no completed trips" do
      before { get "/trip_requests/completed_trips", headers:headers }
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns 0 completed trips" do
        expect(json.size).to eq(0)
      end
    end
    context "when there are completed trips" do
      let!(:trips){ create_list(:trip_request, 5, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:user.id, status: 'completed')}
      before { get "/trip_requests/completed_trips", headers:headers }
      it "returns 200 status code" do
        expect(response).to have_http_status(200)
      end 
      it "returns 5 completed trips" do
        expect(json.size).to eq(5)
      end
    end
    
  end

  describe "GET pending trips" do
    context "when there are no pending trips" do
      before { get "/trip_requests/pending_trips", headers:headers }
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns 10 pending trips" do
        expect(json.size).to eq(15)
      end
    end
  end

  describe "GET on_going trips" do
    context "when there are no on_going trips" do
      before { get "/trip_requests/on_going_trips", headers:headers }
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns 0 on_going trips" do
        expect(json.size).to eq(0)
      end
    end
    context "when there are on_going trips" do
      let!(:trips){ create_list(:trip_request, 5, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:user.id, status: 'on_going')}
      before { get "/trip_requests/on_going_trips", headers:headers }
      it "returns 200 status code" do
        expect(response).to have_http_status(200)
      end 
      it "returns 5 on_going trips" do
        expect(json.size).to eq(5)
      end
    end
  end

  describe "GET cancelled trips" do
    context "when there are no cancelled trips" do
      before { get "/trip_requests/cancelled_trips", headers:headers }
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns 0 cancelled trips" do
        expect(json.size).to eq(0)
      end
    end
    context "when there are completed trips" do
      let!(:trips){ create_list(:trip_request, 5, user_id: user.id, vehicle_type_id: vehicle.id, driver_id:user.id, status: 'cancelled')}
      before { get "/trip_requests/cancelled_trips", headers:headers }
      it "returns 200 status code" do
        expect(response).to have_http_status(200)
      end 
      it "returns 5 cancelled trips" do
        expect(json.size).to eq(5)
      end
    end
  end
  describe "GET trip activities" do
    let!(:activities){create_list(:trip_activity, 5, user_id:user.id, trip_request_id: trips.first.id)}
    before { get "/trip_requests/#{trips.first.token}/activities", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 5 activities" do
      expect(json.size).to eq(5)
    end
  end
end

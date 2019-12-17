require 'rails_helper'

RSpec.describe "TripActivities", type: :request do
  let(:user){create(:user)}
  let!(:vehicle){ create(:vehicle_type) }
  let!(:trip){ create(:trip_request, user_id: user.id, vehicle_type_id: vehicle.id)}
  let!(:activities){create_list(:trip_activity, 10, user_id: user.id, trip_request_id: trip.id)}
  let(:activity_id){activities.first.token}
  let(:headers){valid_headers}

  describe "GET /trip_activities" do
    before {get "/trip_activities", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
    it "returns 10 actitivities" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /trip_activities/:token" do
    context "when the token is valid" do
      before { get "/trip_activities/#{activity_id}", headers:headers }
      it "returns a 200 status code " do
        expect(response).to have_http_status(200)
      end

      it "returns an accurate transaction" do
        expect(json['token']).to eq(activity_id)
      end
    end

    context "when the token is invalid" do
      let(:activity_id){100}
      before { get "/trip_activities/#{activity_id}", headers:headers }

      it "returns a 404 status code " do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /trip_activities" do
    context "when the activity is valid" do
      let(:params){{activity:'Open', user_id:user.id, trip_request_id: trip.id}.to_json}
      before { post "/trip_activities", params:params, headers:headers }

      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      
      it "returns an accurate notification" do
        expect(json['activity']).to eq("Open")
      end
    end

    context "when the activity is invalid" do
      let(:params){{activity:"This is invalid"}.to_json}
      before { post "/trip_activities", params:params, headers:headers }

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /trip_activities/:token" do
    let(:params){{activity:'Discuss'}.to_json }
    before { put "/trip_activities/#{activity_id}", params:params, headers:headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns the accurate transaction" do
      expect(json['activity']).to eq('Discuss')
    end
  end

  describe "DELETE /trip_activities/:token" do
    before { delete "/trip_activities/#{activity_id}", headers:headers }
    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

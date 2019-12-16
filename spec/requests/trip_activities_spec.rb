require 'rails_helper'

RSpec.describe "TripActivities", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}

  describe "GET /trip_activities" do
    before {get "/trip_activities", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end
end

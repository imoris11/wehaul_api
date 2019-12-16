require 'rails_helper'

RSpec.describe "DriverRequests", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}

  describe "GET /driver_requests" do
    before {get "/driver_requests", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end
end

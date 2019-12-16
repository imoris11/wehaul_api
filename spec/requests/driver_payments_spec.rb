require 'rails_helper'

RSpec.describe "DriverPayments", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}

  describe "GET /driver_payments" do
    before { get "/driver_payments", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end
end

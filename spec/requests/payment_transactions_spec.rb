require 'rails_helper'

RSpec.describe "PaymentTransactions", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}

  describe "GET /payment_transactions" do
    before { get "/payment_transactions", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end
end

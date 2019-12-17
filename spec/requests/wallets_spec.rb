require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  let(:user){create(:user, user_type: 'customer')}
  let(:headers){valid_headers}

  describe "GET /wallets" do
    before { get "/wallets", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET user balance" do
    context "when the user is just created" do
      before { get "/wallets/balance", headers:headers }
      it "returns a balance of 0" do
        expect(json['current_balance']).to eq(0)
      end
    end

    context "when the wallet has been updated" do
      let(:params){{created_by: user.id, amount:50000 }.to_json}
      before {put "/wallets/update_balance", params:params, headers:headers}
      it "should return updated balance" do
        expect(json['current_balance']).to eq(50000)
      end
      
      it "should return the right prev balance" do
        expect(json['prev_balance']).to eq(0)
      end
    end

  end
end

require 'rails_helper'

RSpec.describe "PaymentTransactions", type: :request do
  let!(:user){create(:user)}
  let(:headers){valid_headers}
  let!(:payments){create_list(:payment_transaction, 10, user_id:user.id)}
  let(:payment_id){payments.first.token}

  describe "GET /payment_transactions" do
    before { get "/payment_transactions", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 payments" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET own payments" do
    before { get "/payment_transactions/own", headers:headers } 
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 payments" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /payment_transactions/:token" do
    context "when the token is valid" do
      before { get "/payment_transactions/#{payment_id}", headers:headers }
      it "returns a 200 status code " do
        expect(response).to have_http_status(200)
      end

      it "returns an accurate transaction" do
        expect(json['token']).to eq(payment_id)
      end
    end

    context "when the token is invalid" do
      let(:payment_id){100}
      before { get "/payment_transactions/#{payment_id}", headers:headers }

      it "returns a 404 status code " do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /payment_transactions" do
    context "when the transaction is valid" do
      let(:params){{amount:1000, medium:'Test wallet', transaction_ref:'xyref', user_id: user.id}.to_json}
      before { post "/payment_transactions", params:params, headers:headers }

      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end

      it "returns an accurate transaction" do
        expect(json['amount']).to eq(1000)
      end
    end

    context "when the transaction is invalid" do
      let(:params){{amount:1000, medium:'Test wallet'}.to_json}
      before { post "/payment_transactions", params:params, headers:headers }

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an accurate transaction" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
    
  end

  describe "PUT /payment_transactions/:token" do
    let(:params){{amount:2000}.to_json }
    before { put "/payment_transactions/#{payment_id}", params:params, headers:headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns the accurate transaction" do
      expect(json['amount']).to eq(2000)
    end
  end

  describe "DELETE /payment_transactions/:token" do
    before { delete "/payment_transactions/#{payment_id}", headers:headers }

    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end
end

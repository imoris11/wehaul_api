require 'rails_helper'

RSpec.describe "DriverPayments", type: :request do
  let(:user){create(:user)}
  let!(:vehicle){ create(:vehicle_type) }
  let(:trip){create(:trip_request, user_id:user.id, vehicle_type_id:vehicle.id)}
  let(:headers){valid_headers}
  let!(:driver_payments){create_list(:driver_payment, 10, user_id:user.id, trip_request_id:trip.id, created_by:user.id)}
  let(:payment_id){driver_payments.first.token}

  describe "GET /driver_payments" do
    before { get "/driver_payments", headers:headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 items" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /driver_payments/:token" do
    before { get "/driver_payments/#{payment_id}", headers:headers}

    context "when the token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a matching payment" do
        expect(json['token']).to eq(payment_id)
      end
    end

    context "when the token is invalid" do
      let(:payment_id){140}
      before { get "/driver_payments/#{payment_id}", headers:headers}

      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end
      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /driver_payments" do
    context "when the payment is valid" do
      let(:params){{amount:1600, paid_by: 'Richard Igbiriki', user_id:user.id, trip_request_id:trip.id, created_by:user.id }.to_json}
      before { post "/driver_payments", params:params, headers:headers }
      
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      it "returns a new payment" do
        expect(json['paid_by']).to eq('Richard Igbiriki')
      end
    end

    context "when the payment is invalid" do
      let(:params){{amount:1600, paid_by: 'Richard Igbiriki', user_id:user.id }.to_json}
      before { post "/driver_payments", params:params, headers:headers }
      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /driver_payments/:token" do
    let(:params){{amount:1000, paid_by: 'Richard'}.to_json}
    before { put "/driver_payments/#{payment_id}", params:params, headers:headers }

    context "when the token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns an updated payment" do
        expect(json['amount']).to eq(1000)
        expect(json['paid_by']).to eq('Richard')
      end
    end
  end

  describe "DELETE /driver_payments/:token" do
    before { delete "/driver_payments/#{payment_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

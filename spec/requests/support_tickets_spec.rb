require 'rails_helper'

RSpec.describe "SupportTickets", type: :request do
  let!(:user){create(:user)}
  let!(:vehicle){ create(:vehicle_type) }
  let!(:trip){ create(:trip_request, user_id: user.id, vehicle_type_id: vehicle.id)}
  let!(:tickets){create_list(:support_ticket, 10, trip_request_id: trip.id, user_id:user.id)}
  let(:ticket_id){tickets.first.token}
  let(:headers){valid_headers}
  
  describe "GET /support_tickets" do
    before { get "/support_tickets", headers:headers}
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 tickets" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /support_tickets/:token" do
    context "when the token is valid" do
      before { get "/support_tickets/#{ticket_id}", headers:headers }
      it "returns a 200 status code " do
        expect(response).to have_http_status(200)
      end

      it "returns an accurate transaction" do
        expect(json['token']).to eq(ticket_id)
      end
    end

    context "when the token is invalid" do
      let(:ticket_id){100}
      before { get "/support_tickets/#{ticket_id}", headers:headers }

      it "returns a 404 status code " do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /support_tickets" do
    context "when the ticket is valid" do
      let(:params){{content:'This is a test of the support ticket', topic:'Help', user_id:user.id, trip_request_id: trip.id}.to_json}
      before { post "/support_tickets", params:params, headers:headers }

      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      
      it "returns an accurate notification" do
        expect(json['topic']).to eq("Help")
      end
    end

    context "when the ticket is invalid" do
      let(:params){{content:"This is a wrong ticket"}.to_json}
      before { post "/support_tickets", params:params, headers:headers }

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /support_tickets/:token" do
    let(:params){{topic:'Discuss'}.to_json }
    before { put "/support_tickets/#{ticket_id}", params:params, headers:headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns the accurate transaction" do
      expect(json['topic']).to eq('Discuss')
    end
  end

  describe "DELETE /support_tickets/:token" do
    before { delete "/support_tickets/#{ticket_id}", headers:headers }
    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

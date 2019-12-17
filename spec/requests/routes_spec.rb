require 'rails_helper'

RSpec.describe "Routes", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}
  let!(:routes){create_list(:route, 10)}
  let(:route_id){routes.first.token}
  describe "GET /routes" do
    before { get "/routes", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 routes" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /routes/:token" do
    context "when the token is valid" do
      before { get "/routes/#{route_id}", headers:headers }
      it "returns a 200 status code " do
        expect(response).to have_http_status(200)
      end

      it "returns an accurate transaction" do
        expect(json['token']).to eq(route_id)
      end
    end

    context "when the token is invalid" do
      let(:route_id){100}
      before { get "/routes/#{route_id}", headers:headers }

      it "returns a 404 status code " do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /routes" do
    context "when the route is valid" do
      let(:p){{to:"Abuja", from:"Lagos"}.to_json}
      before { post "/routes", params:p, headers:headers }

      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      
      it "returns an accurate notification" do
        expect(json['to']).to eq("Abuja")
        expect(json['from']).to eq("Lagos")
      end
    end

    context "when the route is invalid" do
      let(:params){{to:"Abuja"}.to_json}
      before { post "/routes", params:params, headers:headers }

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /routes/:token" do
    let(:params){{to:'Port Harcourt'}.to_json }
    before { put "/routes/#{route_id}", params:params, headers:headers }

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns the accurate transaction" do
      expect(json['to']).to eq('Port Harcourt')
    end
  end

  describe "DELETE /routes/:token" do
    before { delete "/routes/#{route_id}", headers:headers }
    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end
end

require 'rails_helper'

RSpec.describe "VehicleTypes", type: :request do
  let!(:user){create(:user)}
  let!(:vehicles){create_list(:vehicle_type, 10)}
  let(:vehicle_id){vehicles.first.token}
  let(:headers){valid_headers}

  describe "GET /vehicle_types" do
    context "when it works" do
      before {get "/vehicle_types", headers:headers}
      it "returns a 200 status" do
        expect(response).to have_http_status(200)
      end
      it "returns 10 items" do
        expect(json.size).to eq(10)
      end
    end
    
  end

  describe "GET /vehicle_types/:token" do
    before {get "/vehicle_types/#{vehicle_id}", headers:headers}
    context "when token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a valid vehicle" do
        expect(json['token']).to eq(vehicle_id)
      end
    end

    context "when the token is invalid" do
      let(:vehicle_id){120}
      before {get "/vehicle_types/#{vehicle_id}", headers:headers}
      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /vehicle_types" do
    let(:params){{name:Faker::Lorem.word, description:Faker::Lorem.sentence, max_price_per_km:1200, min_price_per_km:400}.to_json}
    before {post "/vehicle_types", params:params, headers:headers}

    context "when it is valid" do
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end

      it "returns a matching vehicle" do
        expect(json['max_price_per_km']).to eq(1200)
      end
    end

    context "when it is invalid" do
      let(:params){{name:Faker::Lorem.word, description:Faker::Lorem.sentence, min_price_per_km:400}.to_json}
      before {post "/vehicle_types", params:params, headers:headers}

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /vehicle_types" do
    let(:params){{name:'Richard Igbiriki'}.to_json}
    before {put "/vehicle_types/#{vehicle_id}", params:params, headers:headers}
    context "when it is valid" do
      it "returns an updated vehicle" do
        expect(json['name']).to eq("Richard Igbiriki")
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /vehicle_types/:token" do
    before {delete "/vehicle_types/#{vehicle_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

require 'rails_helper'

RSpec.describe "Vehicles", type: :request do
  let!(:user){create(:user)}
  let!(:vehicle_type){ create(:vehicle_type) }
  let!(:vehicles){create_list(:vehicle, 10, user_id: user.id, vehicle_type_id: vehicle_type.id)}
  let(:vehicle_id){vehicles.first.token}
  let(:headers){valid_headers}
  describe "GET /vehicles" do
    before { get "/vehicles", headers:headers}
    context "when it works" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns 10 items" do
        expect(json.size).to eq(10)
      end
    end
  end

  describe "GET /vehicles/:token" do
    before {get "/vehicles/#{vehicle_id}", headers:headers}
    context "when token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
      it "returns a valid vehicle" do
        expect(json['token']).to eq(vehicle_id)
      end
    end


    context "when token is invalid" do
      let(:vehicle_id){120}
      before { get "/vehicles/#{vehicle_id}", headers:headers }
      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /vehicles" do
    let(:params){{plate_number:Faker::Lorem.word, license: Faker::Avatar.image, license_no:"ABC123", serial_no:"12345", license_issue_date:Time.now-12.days, license_expiry_date:Time.now+34.days, vehicle_type_id:vehicle_type.id}.to_json}
    before {post "/vehicles", params:params, headers:headers}
    context "when the object is valid" do
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      
      it "returns a matching vehicle" do
        expect(json['license_no']).to eq("ABC123")
      end
    end

    context "when the object is invalid" do
      let(:params){{serial_no:"12345", license_issue_date:Time.now-12.days, license_expiry_date:Time.now+34.days, vehicle_type_id:vehicle_type.id}.to_json}
      before {post "/vehicles", params:params, headers:headers}
      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /vehicles/:token" do
    let(:params){{serial_no:"12345", license_no:"XYZ", license_issue_date:Time.now-12.days}.to_json}
    before {put "/vehicles/#{vehicle_id}", params:params, headers:headers}
    context "when it is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a valid vehicle" do
        expect(json['license_no']).to eq("XYZ")
      end
    end
  end

  describe "DELETE /vehicles/:token" do
    before {delete "/vehicles/#{vehicle_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end
end

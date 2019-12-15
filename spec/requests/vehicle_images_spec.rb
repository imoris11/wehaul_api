require 'rails_helper'

RSpec.describe "VehicleImages", type: :request do
  let!(:user){create(:user)}
  let!(:vehicle_type){ create(:vehicle_type) }
  let!(:vehicle){create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id)}
  let!(:vehicle_images){create_list(:vehicle_image, 10, vehicle_id: vehicle.id)}
  let(:headers){valid_headers}
  let(:image_id){vehicle_images.first.token}

  describe "GET /vehicle_images" do
    before {get "/vehicle_images", headers: headers}

    context "when it works" do
      it "it returns 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns 10 vehicle images" do
        expect(json.size).to eq(10)
      end
    end
  end

  describe "GET /vehicle_images/:token" do
    before {get "/vehicle_images/#{image_id}", headers:headers}
    context "when the token is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a valid image" do
        expect(json['token']).to eq(image_id)
      end
    end

    context "when the token is invalid" do
      let(:image_id){100}
      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /vehicle_images" do
    let(:image){Faker::Avatar.image}
    let(:params){{image:image, vehicle_id: vehicle.id}.to_json}
    before {post "/vehicle_images", params:params, headers:headers}

    context "when it is a valid image object" do
      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end

      it "returns a matching image" do
        expect(json['image']).to eq(image)
      end
    end

    context "when it is an invalid image object" do
      let(:params){{image:image}.to_json}
      before {post "/vehicle_images", params:params, headers:headers}

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "PUT /vehicle_images/:token" do
    let(:image){Faker::Avatar.image}
    let(:params){{image:image}.to_json}
    before { put "/vehicle_images/#{image_id}", params:params, headers:headers}
    context "when it is valid" do
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
  
      it "returns a matching image" do
        expect(json['image']).to eq(image)
      end
    end
  end

  describe "DELETE /vehicles_images/:token" do
    before {delete "/vehicle_images/#{image_id}", headers:headers}
    it "returns a 204 status code" do
      expect(response).to have_http_status(204)
    end
  end

end

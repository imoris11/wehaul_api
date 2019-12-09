require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  let!(:drivers){create_list(:driver, 5)}
  let(:driver_id){drivers.first.token}

  let(:driver){create(:driver)}
  let(:headers){valid_driver_headers}
  let(:valid_attributes) do
    attributes_for(:driver, password_confirmation: driver.password)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/drivers/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new driver' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/drivers/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Phone number can't be blank, Resident state can't be blank, Vehicle license number can't be blank, Drivers license can't be blank/)
      end
    end
  end

  describe "GET /drivers" do
    before { get "/drivers/drivers", headers:headers }
    context 'when users exists' do
      it 'returns users' do
        expect(json).not_to be_empty
        expect(json.size).to eq(6)
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /drivers/:token" do
    before { get "/drivers/drivers/#{driver_id}", headers: headers }

    context "when token is valid" do
      it "returns a driver" do
        expect(json).not_to be_empty
        expect(json['token']).to eq(driver_id)
      end

      it "returns a 200 status" do
        expect(response).to have_http_status(200)
      end
    end

    context "when token is invalid" do
      let(:driver_id){200}
      it "returns 404 status code" do
        expect(response).to have_http_status(404)
      end

      it 'returns a message' do
        expect(response.message).to match(/Not Found/)
      end
    end

  end

  describe "PUT /drivers/:token" do
    let(:params){{name:'Richard', email:'user@mail.com'}.to_json}
    before {put "/drivers/drivers/#{driver_id}", params:params, headers:headers }

    context "when it is valid" do
      it "returns a driver" do
        expect(json['name']).to eq('Richard')
        expect(json['email']).to eq('user@mail.com')
        expect(json).not_to be_empty
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE drivers/token" do
    before { delete "/drivers/drivers/#{driver_id}", headers:headers }
    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end


end

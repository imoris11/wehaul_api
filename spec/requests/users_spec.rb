require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 5)}
  let(:user_id) {users.first.token}
  #user auth details
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
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
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe "GET /users" do 
    before { get "/users", headers: headers}
    it 'returns users' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(6)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe "GET /users/:id" do
    before { get "/users/#{user_id}", headers: headers}

    context "when records exist" do
      it "returns a user" do
        expect(json).not_to be_empty
        expect(json['token']).to eq(user_id)
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
      end

    end

    context "when record doesn't exist" do
      let(:user_id){100}

      it 'expects 404 status' do
        expect(response).to have_http_status(404)
      end

      it 'returns a found message' do
        expect(response.message).to match(/Not Found/)
      end

    end
  end

    describe "PUT /users/:id" do
      context "when request is valid" do
        before{ put "/users/#{user_id}", params:{role: "Super Admin" }.to_json, headers: headers }
        
        it "should update role" do
          expect(json['role']).to eq("Super Admin")
        end

        it "returns 200 status code" do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "PUT /users/:token/update_profile" do
      let(:params){{profile_picture: Faker::Avatar.image, address:Faker::Address.street_address, vehicle_license_number: '12345678' }.to_json}
      before { put "/users/#{user_id}/update_profile", params: params, headers:headers }

      context "when it is valid" do
        it "returns a  200 status code" do
          expect(response).to have_http_status(200)
        end

        it "returns corresponding profile" do
          expect(json['profile']['vehicle_license_number']).to eq('12345678')
        end
      end

    end


    describe "DELETE /users/:id" do
      before { delete "/users/#{user_id}", headers: headers }

      it "returns 204 status" do
        expect(response).to have_http_status(204)
      end
    end


end

require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let!(:users) { create_list(:user, 5, role:'customer', user_type:'customer')}
  let(:user_id) {users.first.token}
  #user auth details
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe "GET customers" do 
    before { get "/admins/customers", headers: headers}
    it 'returns users' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe "GET /admins/customers/:id" do
    before { get "/admins/customers/#{user_id}", headers: headers}

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
      before { get "/admins/customers/#{user_id}", headers: headers}
      it 'expects 404 status' do
        expect(response).to have_http_status(404)
      end

      it 'returns a found message' do
        expect(response.message).to match(/Not Found/)
      end

    end
  end

    describe "PUT /admins/customers/:id" do
      context "when request is valid" do
        before{ put "/admins/customers/#{user_id}", params:{role: "admin" }.to_json, headers: headers }
        
        it "should update role" do
          expect(json['role']).to eq("admin")
        end

        it "returns 200 status code" do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "PUT /admins/customers/:token/update_profile" do
      let(:params){{profile_picture: Faker::Avatar.image, address:Faker::Address.street_address, resident_state: 'Bayelsa' }.to_json}
      before { put "/admins/customers/#{user_id}/update_profile", params: params, headers:headers }

      context "when it is valid" do
        it "returns a  200 status code" do
          expect(response).to have_http_status(200)
        end

        it "returns corresponding profile" do
          expect(json['profile']['resident_state']).to eq('Bayelsa')
        end
      end

    end
end

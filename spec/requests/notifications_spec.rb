require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user){create(:user)}
  let(:headers){valid_headers}
  let!(:notifications){create_list(:notification, 10, user_id: user.id)}
  let!(:notification_id){notifications.first.token}

  describe "GET /notifications" do
    before { get "/notifications", headers:headers }
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "returns 10 notifications" do
      expect(json.size).to eq(10)
    end
  end

  describe "GET /notifications/:token" do
    context "when the token is valid" do
      before {get "/notifications/#{notification_id}", headers:headers }
      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns the correct notificaton" do
        expect(json['token']).to eq(notification_id)
      end
    end

    context "when the token is invalid" do
      let(:notification_id){120}
      before {get "/notifications/#{notification_id}", headers:headers }

      it "returns a 404 status code" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.message).to match(/Not Found/)
      end
    end
  end

  describe "POST /notifications" do
    context "when the notification is valid" do
      let(:p){{target:"Richard", message:"Likes this post", user_id: user.id}.to_json}
      before { post "/notifications", params:p, headers:headers }

      it "returns a 201 status code" do
        expect(response).to have_http_status(201)
      end
      
      it "returns an accurate notification" do
        expect(json['target']).to eq("Richard")
      end
    end

    context "when the notification is invalid" do
      let(:params){{target:"Richard", user_id: user.id}.to_json}
      before { post "/notifications", params:params, headers:headers }

      it "returns a 422 status code" do
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        expect(response.message).to match(/Unprocessable Entity/)
      end
    end
  end

  describe "DELETE /notifications/:token" do
    before { delete "/notifications/#{notification_id}", headers:headers}

    it "returns 204 status code" do
      expect(response).to have_http_status(204)
    end
  end
end

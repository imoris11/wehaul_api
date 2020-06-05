require 'rails_helper'

RSpec.describe "Trackings", type: :request do
  describe "GET /trackings" do
    it "works! (now write some real specs)" do
      get trackings_path
      expect(response).to have_http_status(200)
    end
  end
end

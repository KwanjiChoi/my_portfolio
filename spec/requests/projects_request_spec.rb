require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user) { create(:user) }

  describe "GET /show" do
    it "returns http success" do
      get "/projects/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in user
      get "/projects/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      sign_in user
      get "/projects/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/projects/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      sign_in user
      get "/projects/new"
      expect(response).to have_http_status(:success)
    end
  end
end

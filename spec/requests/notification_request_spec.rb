require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }

  describe 'GET #index', focus: true do
    it '' do
      sign_in user
      get user_notifications_path(user)
      expect(response).to have_http_status(:success)
    end

    it '' do
      sign_in other_user
      get user_notifications_path(user)
      expect(response.status).to eq 302
    end

    it '' do
      get user_notifications_path(user)
      expect(response.status).to eq 302
    end
  end
end
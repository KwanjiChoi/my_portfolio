require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }

  describe 'GET #index' do
    it 'when sign in user' do
      sign_in user
      get user_notifications_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'not correct user' do
      sign_in other_user
      get user_notifications_path(user)
      expect(response.status).to eq 302
    end

    it 'when not sing in user' do
      get user_notifications_path(user)
      expect(response.status).to eq 302
    end
  end
end

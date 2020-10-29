require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "GET apply_teacher" do
    it "returns response code 200" do
      sign_in user
      get apply_teacher_users_path
      expect(response).to have_http_status(200)
    end

    it "returns response code 302 when user does not logged in" do
      get apply_teacher_users_path
      expect(response).to have_http_status(302)
    end

    it 'returns response code 302 when user is already teacher account' do
      user.teacher = true
      sign_in user
      get apply_teacher_users_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET activate_teacher' do
    it "returns response code 200" do
      sign_in user
      get activate_teacher_user_path(user)
      expect(response).to have_http_status(200)
    end

    it "returns response code 302 when user does not logged in" do
      get activate_teacher_user_path(user)
      expect(response).to have_http_status(302)
    end

    it 'returns response code 302 when user already teacher account' do
      user.teacher = true
      sign_in user
      get activate_teacher_user_path(user)
      expect(response).to have_http_status(302)
    end

    it 'returns response code 302 when activate other user account' do
      sign_in user
      get activate_teacher_user_path(other_user)
      expect(response).to have_http_status(302)
    end
  end
end
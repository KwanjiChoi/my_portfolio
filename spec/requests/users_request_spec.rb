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

    it 'returns response code 302 when user has unconfirmed email' do
      sign_in user
      user.unconfirmed_email = 'sample@sample.com'
      get activate_teacher_user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #projects' do
    it 'whoever can get User#projects' do
      get projects_user_path(user)
      expect(response).to have_http_status(:success)

      sign_in user
      get projects_user_path(other_user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit', focus: true do
    it 'returns response code 200 when correct user' do
      sign_in user
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'returns response code 302 when incorrect user' do
      sign_in other_user
      get edit_user_path(user)
      expect(response).to have_http_status(302)
    end

    it 'returns response code 302 when user does not sign in' do
      get edit_user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    let(:user_params) do
      {
        username: 'Username',
        phone_number: '09000000000',
        introduction: 'よろしくー',
      }
    end

    it 'updates successfully' do
      sign_in user
      put user_path(user), params: { user: user_params }
      expect(user.reload.username).to eq 'Username'
    end

    it 'does not update when other user' do
      name = user.username
      sign_in other_user
      put user_path(user), params: { user: user_params }
      expect(user.reload.username).to eq name
    end

    it 'does not update when user does not sign in' do
      name = user.username
      put user_path(user), params: { user: user_params }
      expect(user.reload.username).to eq name
    end
  end
end

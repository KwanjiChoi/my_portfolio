require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  let!(:owner)       { create(:user, :teacher_account) }
  let!(:requester)   { create(:user) }
  let!(:project)     { create(:project, user: owner) }
  let!(:reservation) { create(:reservation, project: project, requester: requester) }

  describe 'GET #new' do
    it 'http success when user signed in' do
      sign_in requester
      get new_project_reservation_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'http code 302 when user does not singned in' do
      get new_project_reservation_path(project)
      expect(response.code).to eq '302'
    end
  end

  describe 'POST #create' do
  end

  describe 'GET #show_active' do
    it 'http code 302 when user does not singned in' do
      get user_reservation_path(requester, reservation)
      expect(response.code).to eq '302'
    end

    it 'http success when correct_user get show_active page' do
      sign_in requester
      get user_reservation_path(requester, reservation)
      expect(response).to have_http_status(:success)
    end

    it 'http code 302 when user get other users show_acive page' do
      sign_in owner
      get user_reservation_path(requester, reservation)
      expect(response.code).to eq '302'
    end
  end

  describe 'GET #show_active' do
  end

  describe 'GET #show_passive' do
  end

  describe 'GET #edit' do
  end

  descrbe 'GET #update' do
  end
end

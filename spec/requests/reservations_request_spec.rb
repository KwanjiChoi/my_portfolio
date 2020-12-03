require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  let!(:owner)       { create(:user, :teacher_account) }
  let!(:requester)   { create(:user) }
  let!(:project)     { create(:project, user: owner) }
  let!(:reservation) { create(:reservation, project: project, requester: requester) }
  let(:other_user)   { create(:user) }

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
    let(:reservation_params) do
      attributes_for(:reservation,
                     project: project,
                     # ストロングパラメーターで設定した属性にしないと弾かれる ✖︎requester ○requester_id
                     requester_id: requester.id,
                     request_text: 'よろしくお願いいたします',
                     start_at: Time.now.tomorrow,
                     reserve_time: 60)
    end

    let!(:other_user) { create(:user) }

    it 'adds a reservation' do
      sign_in requester
      expect do
        post project_reservations_path(project), params: { reservation: reservation_params }
      end.to change(Reservation, :count).by(1)
    end

    it 'does not add a reservation when user not logged in' do
      expect do
        post project_reservations_path(project), params: { reservation: reservation_params }
      end.not_to change(Reservation, :count)
    end

    it 'does not add a reservation when requester is other user' do
      sign_in other_user
      expect do
        post project_reservations_path(project), params: { reservation: reservation_params }
      end.not_to change(Reservation, :count)
    end
  end

  describe 'GET #show_active' do
    let!(:room) { create(:room, reservation: reservation) }

    it 'http code 302 when user does not singned in' do
      get active_reservation_path(requester, reservation)
      expect(response.code).to eq '302'
    end

    it 'http success when correct_user' do
      sign_in requester
      get active_reservation_path(requester, reservation)
      expect(response).to have_http_status(:success)
    end

    it 'http code 302 when user get other users show_acive page' do
      sign_in owner
      get active_reservation_path(requester, reservation)
      expect(response.code).to eq '302'
    end
  end

  describe 'GET #show_passive' do
    it 'http code 302 when user does not singned in' do
      get passive_reservation_path(project, reservation)
      expect(response.code).to eq '302'
    end

    it 'http success when correct user' do
      sign_in owner
      get passive_reservation_path(project, reservation)
      expect(response).to have_http_status(:success)
    end

    it 'http code 302 when not correct user' do
      sign_in requester
      get passive_reservation_path(project, reservation)
      expect(response.code).to eq '302'
    end
  end

  describe 'GET #edit' do
    it 'http code 302 when user does not singned in' do
      get edit_project_reservation_path(project, reservation)
      expect(response.code).to eq '302'
    end

    it 'gets by project owner' do
      sign_in owner
      get edit_project_reservation_path(project, reservation)
      expect(response).to have_http_status(:success)
    end

    it 'gets by requester' do
      sign_in requester
      get edit_project_reservation_path(project, reservation)
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 302 when other user get edit page' do
      sign_in other_user
      get edit_project_reservation_path(project, reservation)
      expect(response.code).to eq '302'
    end
  end

  describe 'PATCH #update' do
    it do
      expect(1 + 1).to eq 2
    end
  end
end

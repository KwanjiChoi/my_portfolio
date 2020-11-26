require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  let!(:owner)     { create(:user, :teacher_account) }
  let!(:requester) { create(:user) }
  let!(:project)   { create(:project, user: owner) }

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
end

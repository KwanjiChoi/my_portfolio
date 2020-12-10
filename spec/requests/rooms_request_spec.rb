require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  include_examples 'make reservation'

  describe 'GET #show' do
    it 'requester should get chat room' do
      sign_in requester
      get room_path(room)
      expect(response).to have_http_status(200)
    end

    it 'returns http code 302 when user not signed in' do
      get room_path(room)
      expect(response).to have_http_status(302)
    end

    it 'supplier should get chat room' do
      sign_in supplier
      get room_path(room)
      expect(response).to have_http_status(200)
    end

    it 'returns http code 302 when other user get chat room' do
      sign_in other_user
      get room_path(room)
      expect(response).to have_http_status(302)
    end
  end
end

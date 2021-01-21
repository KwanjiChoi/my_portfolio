require 'rails_helper'

RSpec.describe "Exceptions", type: :request do
  let(:user) { create(:user) }

  context 'user page' do
    it 'get not found' do
      not_found_user_id = user.id - 1
      sign_in user
      get user_path(not_found_user_id)
      expect(response.code).to eq '302'
    end
  end

  context 'project page' do
    it 'get not found' do
      sign_in user
      get detail_project_path(1)
      expect(response.code).to eq '302'
    end
  end
end

require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:user) { create(:user) }

  describe "GET root_path" do
    it "returns response code 200" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it 'returns response code 302 when sign in user get root_path' do
      sign_in user
      get root_path
      expect(response.code).to eq '302'
    end
  end
end

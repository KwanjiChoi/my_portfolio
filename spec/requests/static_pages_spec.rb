require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET root_path" do
    it "returns respense code 200" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end

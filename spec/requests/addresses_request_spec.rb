require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }

  describe "GET /index" do
    it "returns http status 302 when user not logged in" do
      get user_addresses_path(user)
      expect(response.code).to eq "302"
    end

    it "returns http success when user logged in" do
      sign_in user
      get user_addresses_path(user)
      expect(response).to have_http_status(:success)
    end

    it "returns http status 302 when get other user's address index page" do
      sign_in user
      get user_addresses_path(other_user)
      expect(response.code).to eq '302'
    end
  end

  describe 'POST /create' do
    it 'adds a address' do
      sign_in user
      expect  do
        post user_addresses_path(user), params: { address: attributes_for(:address) }
      end.to change(user.addresses, :count).by(1)
    end

    it 'does not add a address when user not logged in' do
      expect do
        post user_addresses_path(user), params: { address: attributes_for(:address) }
      end.not_to change(user.addresses, :count)
    end

    it 'does not add a address when params is nil' do
      sign_in user
      expect  do
        post user_addresses_path(user), params: { address: attributes_for(:address, :invalid) }
      end.not_to change(user.addresses, :count)
    end

    it 'does not add a address when user already has 5 addresses' do
      create_list(:address, 5, user: user)
      sign_in user
      expect  do
        post user_addresses_path(user), params: { address: attributes_for(:address) }
      end.not_to change(user.addresses, :count)
    end

    it 'after create address redirect to address index path' do
      sign_in user
      post user_addresses_path(user), params: { address: attributes_for(:address) }
      expect(response).to redirect_to(user_addresses_path(user))
    end
  end

  describe 'DELETE /destroy' do
    let!(:address)       { create(:address, user: user) }
    let!(:other_address) { create(:address, user: other_user) }

    it 'deletes address' do
      sign_in user
      expect  do
        delete user_address_path(user, address)
      end.to change(user.addresses, :count).by(-1)
    end

    it 'deos not delete address when user does not logged in' do
      expect do
        delete user_address_path(user, address)
      end.not_to change(user.addresses, :count)
    end

    it 'does not delete other users address' do
      sign_in user
      expect  do
        delete user_address_path(other_user, other_address)
      end.not_to change(other_user.addresses, :count)
    end

    it 'after create address redirect to address index path' do
      sign_in user
      delete user_address_path(user, address)
      expect(response).to redirect_to(user_addresses_path(user))
    end
  end
end

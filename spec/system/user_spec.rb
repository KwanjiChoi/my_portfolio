require 'rails_helper'

RSpec.describe "User", type: :system do
  describe 'omniauth sign in' do
    before do
      visit root_path
      click_link "login"
    end

    context 'via facebook' do
      before do
        OmniAuth.config.mock_auth[:facebook] = nil
        Rails.application.env_config['omniauth.auth'] = facebook_mock
      end

      scenario 'increase User count when first login' do
        expect do
          find(".btn-facebook").click
        end.to change(User, :count).by(1)
      end

      scenario 'not increase User count when not first login' do
        find(".btn-facebook").click
        click_link "ログアウト"
        click_link "login"
        expect do
          find(".btn-facebook").click
        end.not_to change(User, :count)
      end
    end

    context 'via twitter' do
      before do
        OmniAuth.config.mock_auth[:twitter] = nil
        Rails.application.env_config['omniauth.auth'] = twitter_mock
      end

      scenario 'increase User count when first login' do
        expect do
          find(".btn-twitter").click
        end.to change(User, :count).by(1)
      end

      scenario 'not increase User count when not first login' do
        find(".btn-twitter").click
        click_link "ログアウト"
        click_link "login"
        expect do
          find(".btn-twitter").click
        end.not_to change(User, :count)
      end
    end
  end
end

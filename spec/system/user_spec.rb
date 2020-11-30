require 'rails_helper'

RSpec.describe "User", type: :system do
  describe 'account service' do
    include_examples 'sign in'

    scenario 'user activate teacher account' do
      visit root_path
      within 'nav' do
        expect(page).to have_no_content 'MYプロジェクト'
        expect(page).to have_content    '人に教える'
      end

      user.activate_teacher

      visit root_path
      within 'nav' do
        expect(page).to have_content    'MYプロジェクト'
        expect(page).to have_no_content '人に教える'
      end
    end

    scenario 'unconfirmed user should not apply teacher account' do
      user.update_attribute(:unconfirmed_email, 'example@example.com')
      visit apply_teacher_users_path
      expect(page).to have_content 'teacherアカウントの登録にはメール認証が必要です'
    end
  end

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

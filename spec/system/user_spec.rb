require 'rails_helper'

RSpec.describe "User", type: :system do
  let!(:user) { create(:user, :sample_user) }

  scenario 'user creates addresses' do
    visit root_path
    within 'nav' do
      expect(page).to have_link 'login', href: new_user_session_path, count: 1
    end
    click_link 'login'
    fill_in    'Email',    with: 'tester@example.com'
    fill_in    'Password', with: 'password'
    click_on   'Log in'
    expect(page).to have_css     '.notifications'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'ログアウト'
    expect(page).to have_css     '.notifications'
    expect(page).to have_content 'Signed out successfully.'   
  end
end
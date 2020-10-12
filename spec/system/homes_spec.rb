require 'rails_helper'

RSpec.describe "Home", type: :system do
  let!(:user) { create(:user) }
  scenario 'user log in' do
    visit root_path
    within 'nav' do
      expect(page).to have_link 'login', href: new_user_session_path, count: 1
    end
  end
end

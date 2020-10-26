require 'rails_helper'

RSpec.describe "Address", type: :system do
  let!(:user_addresses) { create_list(:address, 3, user: user) }
  let!(:tokyo)          { create(:address, :tokyo, user: user) }

  include_examples 'sign in'
  include_examples 'googlemap api'

  scenario 'user creates addresses' do
    visit dashboard_path
    click_link 'ワークスペース登録'
    expect(page).to have_content 'あと1件登録可能です'

    fill_in  'address[address]', with: ''
    click_on 'create address'
    within '#error_explanation' do
      expect(page).to have_content "Address can't be blank"
    end
    expect(page).to have_content 'あと1件登録可能です'

    fill_in  'address[address]', with: 'meaningless address'
    click_on 'create address'
    within '#error_explanation' do
      expect(page).to have_content "Address は無効な住所です"
    end

    fill_in  'address[address]', with: "New York, NY"
    click_on 'create address'
    within '#notifications' do
      expect(page).to have_content 'created successfully'
    end

    user_addresses_path(user)
    expect(page).to have_content '最大件数登録済みです'
    fill_in  'address[address]', with: 'New York, NY'
    click_on 'create address'
    within '#error_explanation' do
      expect(page).to have_content 'Address の登録は最大5件までです'
    end

    expect(page).to have_content 'New York, NY', count: 4
    expect(page).to have_content 'Tokyo',        count: 1
    expect(page).to have_link    '削除', count: 5

    find("#delete-#{tokyo.id}").click
    within '#notifications' do
      expect(page).to have_content 'deleted successfully'
    end
    expect(page).to have_content    'あと1件登録可能です'
    expect(page).to have_no_content 'Tokyo'
  end
end

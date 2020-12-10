require 'rails_helper'

RSpec.describe "Chat room", type: :system do
  include_examples 'make reservation'

  scenario 'have talk in chat room' do
    sign_in requester
    visit detail_project_path(project)
    click_button 'reservation now!!'
    click_link 'このまま予約する'
    fill_in 'reservation_start_at', with: Time.now.tomorrow
    select '60分', from: '予約時間'
    fill_in 'reservation[request_text]', with: 'よろしくお願いいたします！'

    click_button 'Make a reservation!'

    expect(page).to have_content '予約が完了いたしました'
    click_link 'Message'
    expect(page).to have_content '予約を受け付けました！ 確認まで少々お待ちください。'
  end
end

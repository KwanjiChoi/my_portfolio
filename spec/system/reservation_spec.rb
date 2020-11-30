require 'rails_helper'

RSpec.describe "Reservation", type: :system do
  let!(:teacher)     { create(:user, :teacher_account) }
  let!(:project)     { create(:project, user: teacher) }
  let!(:user)        { create(:user) }
  let!(:reservation) { create(:reservation, requester: user, project: project) }

  def reservation_count(unchecked:, checked:, finished:)
    within '.unchecked-reservations' do
      expect(page).to have_selector '.reservation-card', count: unchecked
    end
    within '.checked-reservations' do
      expect(page).to have_selector '.reservation-card', count: checked
    end
    within '.finished-reservations' do
      expect(page).to have_selector '.reservation-card', count: finished
    end
  end

  scenario 'reservation card' do
    sign_in user
    visit user_reservations_path(user)
    within '.unchecked-reservations' do
      expect(page).to have_content reservation.created_at.strftime('%Y/%m/%d %H:%M:%S')
    end
  end

  scenario 'user has reservation' do
    sign_in user
    visit user_reservations_path(user)
    reservation_count(unchecked: 1, checked: 0, finished: 0)

    reservation.update_attribute(:status, 'checked')
    visit user_reservations_path(user)
    reservation_count(unchecked: 0, checked: 1, finished: 0)

    reservation.update_attribute(:status, 'finished')
    visit user_reservations_path(user)
    reservation_count(unchecked: 0, checked: 0, finished: 1)
  end
end

require 'rails_helper'

RSpec.describe ReservationDecorator do
  let(:reservation) { create(:reservation) }

  context 'start_at' do
    subject { reservation.decorate.start_at }

    it { is_expected.to eq reservation.start_at.strftime('%Y/%m/%d %H:%M') }
  end

  context 'show_reserve_time' do
    subject { reservation.decorate.show_reserve_time }

    it { is_expected.to eq '60分' }
  end

  context 'owner_name' do
    subject { reservation.decorate.owner_name }

    it { is_expected.to eq reservation.project.owner }
  end
end

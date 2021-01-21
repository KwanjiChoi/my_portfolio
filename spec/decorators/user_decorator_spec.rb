require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { create(:user) }
  let!(:reservation_notification) do
    create(:reservation_notification, visited: user)
  end

  context 'unchecked_notifications_count' do
    subject { user.decorate.unchecked_notifications_count }

    it { is_expected.to eq 1 }
  end

  context 'has_unchecked_notifications?' do
    subject { user.decorate.has_unchecked_notifications? }

    it { is_expected.to be true }
  end
end

require 'rails_helper'

RSpec.describe NotificationDecorator do
  let(:notification) { create(:comment_notification) }

  context 'visitor_name' do
    subject { notification.decorate.visitor_name }

    it { is_expected.to eq notification.visitor.username }
  end

  context 'created_at' do
    it do
      notification = create(:comment_notification)
      travel_to 30.minutes.after do
        expect(notification.decorate.created_at).to eq '30 minutes'
      end
    end
  end
end

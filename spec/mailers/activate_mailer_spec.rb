require "rails_helper"

RSpec.describe ActivateMailer, type: :mailer do
  describe '#send_activate_techer_account' do
    subject(:mail) do
      described_class.send_activate_teacher_account(user).deliver_now
    end

    let!(:user) { create(:user, username: 'Mailer Tester') }

    context 'when send_mail' do
      it { expect(mail.from).to include 'mk09210416@gmail.com' }
      it { expect(mail.to).to include user.email }
      it { expect(mail.subject).to eq 'teacher機能をアクティベートしました' }
      it { expect(mail.body).to match /Mailer Tester/ }
    end
  end
end

require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:comment) { create(:user_comment) }

  context 'created_at' do
    subject { comment.decorate.created_at }

    it { is_expected.to eq comment.created_at.strftime('%m月%d日') }
  end

  context 'commenter_name' do
    subject { comment.decorate.commenter_name }

    it { is_expected.to eq comment.commenter.username }
  end

  context 'commenter' do
    subject { comment.decorate.comment }

    it { is_expected.to eq comment.comment }
  end
end

require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @project = build(:project)
  end

  it 'has valid factory' do
    expect(@project).to be_valid
  end

  describe 'validation' do
    context 'title' do
      it 'is invalid when title is nil' do
        @project.title = nil
        @project.valid?
        expect(@project.errors[:title]).to include "can't be blank"
      end

      it 'is invalid when title is blank' do
        @project.title = '     '
        @project.valid?
        expect(@project.errors[:title]).to include "can't be blank"
      end

      it 'is invalid when title is over 50 characters' do
        @project.title = 'a' * 51
        @project.valid?
        expect(@project.errors[:title]).to include "is too long (maximum is 50 characters)"
      end

      it 'is invalid when title is within 2 characters' do
        @project.title = 'a'
        @project.valid?
        expect(@project.errors[:title]).to include "is too short (minimum is 2 characters)"
      end
    end

    context 'project_category_id' do
      it 'is invalid when project_category_id is nil' do
        @project.project_category = nil
        @project.valid?
        expect(@project.errors[:project_category]).to include "must exist"
      end
    end

    context 'main_image' do
      it 'is invalid when main_image is nil' do
        @project.main_image = nil
        @project.valid?
        expect(@project.errors[:main_image]).to include "can't be blank"
      end
    end

    context 'content' do
      it 'is invalid when content is nil' do
        @project.content = nil
        @project.valid?
        expect(@project.errors[:content]).to include "can't be blank"
      end

      it 'is invalid when content is blank' do
        @project.content = '    '
        @project.valid?
        expect(@project.errors[:content]).to include "can't be blank"
      end

      it 'is invalid when title is over 2000 characters' do
        @project.content = 'a' * 2001
        @project.valid?
        expect(@project.errors[:content]).to include "is too long (maximum is 2000 characters)"
      end

      it 'is invalid when title is within 100 characters' do
        @project.content = 'a' * 1
        @project.valid?
        expect(@project.errors[:content]).to include "is too short (minimum is 100 characters)"
      end
    end

    context 'phone_reservation' do
      it 'is invalid when user did not registrate phone number' do
        @project.user.phone_number = nil
        @project.phone_reservation = true
        @project.valid?
        expect(@project.errors[:phone_reservation]).to include "電話予約を設定するには電話番号の登録が必要です"
      end
    end
  end

  describe 'relation' do
    let!(:user)    { create(:user) }
    let!(:project) { create(:project, user: user) }

    it 'dependent destroy' do
      expect { user.destroy }.to change(Project, :count)
    end
  end

  describe 'instance mothod' do
    file = File.open 'spec/fixtures/sample_content.txt'
    content = file.read
    let!(:sample_project) { create(:project, content: content) }

    context 'short_content' do
      expected = "昔の人々は、明るい星を結んで星座を思い描きました。星座を作ったのは、シュメール人という説もありますが、
      一般的には、約五千年前、バビロニアの羊飼いたちによ...".gsub(/[\r\n[:space:]]/, "")
      it 'returns only 75 characters' do
        expect(sample_project.short_content).to eq(expected)
      end
    end
  end
end

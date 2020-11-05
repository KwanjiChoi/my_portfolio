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
    end
  end

  describe 'relation' do
    let!(:user)    { create(:user) }
    let!(:project) { create(:project, user: user) }

    it 'dependent destroy' do
      expect { user.destroy }.to change(Project, :count)
    end
  end
end

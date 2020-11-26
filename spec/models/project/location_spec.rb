require 'rails_helper'

RSpec.describe Project::Location, type: :model do
  describe 'validation' do
    before do
      @project_location = build(:project_location)
    end

    it 'has a valid factory' do
      expect(@project_location).to be_valid
    end
    context 'prefecture_id' do
      it 'is invalid when prefecture id is nil' do
        @project_location.prefecture_id = nil
        @project_location.valid?
        expect(@project_location.errors[:prefecture_id]).to include "can't be blank"
      end
    end
  end

  describe 'relation' do
    let!(:project)          { create(:project) }
    let!(:project_location) { create(:project_location, project: project) }

    it 'dependent destroy' do
      expect { project.destroy }.to change(Project::Location, :count)
    end
  end
end

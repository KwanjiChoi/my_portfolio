require 'rails_helper'

RSpec.describe Project::Location, type: :model do
  describe 'validation' do
    let!(:project) { build(:project) }
    let!(:location) { build(:project_location) }

    it 'has valid factory' do
      expect(location).to be_valid
    end

    context 'prefecture' do
      it 'is invalid when prefecture in nil' do
        location.prefecture = nil
        expect(location).not_to be_valid
      end
    end

    context 'city' do
      it 'is invalid when city in nil' do
        location.city = nil
        expect(location).not_to be_valid
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

require 'rails_helper'

RSpec.describe Project::Location, type: :model do
  describe 'validation' do
    let!(:project) { build(:project) }
    let!(:location) { build(:project_location) }

    it 'has valid factory' do
      expect(location).to be_valid
    end

    context 'address' do
      it 'is invalid when address in nil' do
        location.address = nil
        expect(location).not_to be_valid
      end

      it 'is invalid when address in blank' do
        location.address = ' '
        expect(location).not_to be_valid
      end

      it 'is invalid when address is too short' do
        location.address = 'あ'
        expect(location).not_to be_valid
      end

      it 'is invalid when address is too long' do
        location.address = 'あ' * 51
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

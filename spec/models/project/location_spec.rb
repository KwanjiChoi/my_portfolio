require 'rails_helper'

RSpec.describe Project::Location, type: :model do
  describe 'validation' do
    let!(:project) { build(:project) }
    let!(:location) { build(:project_location) }

    it 'has valid factory' do
      puts project.user.username
      puts location.project.title
      puts location.prefecture.name

      expect(location).to be_valid
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

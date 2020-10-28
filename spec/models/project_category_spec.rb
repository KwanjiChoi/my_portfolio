require 'rails_helper'

RSpec.describe ProjectCategory, type: :model do
  before do
    @project_category = build(:project_category)
  end

  it 'has a valid factory' do
    expect(@project_category).to be_valid
  end

  describe 'validation' do
    it 'is invalid when name is nil' do
      @project_category.name = nil
      @project_category.valid?
      expect(@project_category.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when name is blank' do
      @project_category.name = '  '
      @project_category.valid?
      expect(@project_category.errors[:name]).to include("can't be blank")
    end

    context 'uniqueness' do
      let!(:project_category) { create(:project_category, name: 'Sample category') }

      it 'is invalid when name already taken' do
        category = build(:project_category, name: 'Sample category')
        category.valid?
        expect(category.errors[:name]).to include("has already been taken")
      end

      it 'is invalid' do
        category = build(:project_category, name: 'sample category')
        category.valid?
        expect(category.errors[:name]).to include("has already been taken")
      end
    end
  end
end

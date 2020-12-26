require 'rails_helper'

RSpec.describe Performance, type: :model do
  describe 'validation' do
    let(:user_performance)    { build(:user_performance) }
    let(:project_performance) { build(:project_performance) }

    it 'has valid factory' do
      expect(user_performance).to be_valid
      expect(project_performance).to be_valid
    end

    context 'total_record' do
      it 'is not nil' do
        user_performance.total_record = nil
        expect(user_performance).not_to be_valid

        project_performance.total_record = nil
        expect(project_performance).not_to be_valid
      end
    end

    context 'average_score' do
      it 'allows nil' do
        user_performance.average_score = nil
        expect(user_performance).to be_valid

        project_performance.average_score = nil
        expect(project_performance).to be_valid
      end

      it 'is greater than or equal to 1' do
        user_performance.average_score = 0.9
        expect(user_performance).not_to be_valid

        project_performance.average_score = 0.9
        expect(project_performance).not_to be_valid
      end

      it 'is less than or equal to 5' do
        user_performance.average_score = 5.1
        expect(user_performance).not_to be_valid

        project_performance.average_score = 5.1
        expect(project_performance).not_to be_valid
      end
    end
  end
end

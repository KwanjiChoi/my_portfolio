require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:user_comment)    { build(:user_comment) }
    let(:project_comment) { build(:project_comment) }

    it 'has valid factories' do
      expect(user_comment).to be_valid
      expect(project_comment).to be_valid
    end

    describe 'comment' do
      it 'is not valid when comment is blank' do
        user_comment.comment = nil
        user_comment.valid?
        expect(user_comment.errors[:comment]).to include "can't be blank"
      end
    end

    describe 'score' do
      it 'is not valid when score is blank' do
        user_comment.score = nil
        user_comment.valid?
        expect(user_comment.errors[:score]).to include "can't be blank"
      end

      it 'is not valid when score is not integer' do
        user_comment.score = 'hello'
        user_comment.valid?
        expect(user_comment.errors[:score]).to include "is not a number"
      end

      it 'is not valid when score is not within 1 ~ 5' do
        user_comment.score = 0
        user_comment.valid?
        expect(user_comment.errors[:score]).to include "must be greater than or equal to 1"

        user_comment.score = 6
        user_comment.valid?
        expect(user_comment.errors[:score]).to include "must be less than or equal to 5"
      end
    end
  end

  describe 'association' do
    describe 'dependent destroy' do
      let!(:commenter)       { create(:user) }
      let!(:user)            { create(:user) }
      let!(:project)         { create(:project) }
      let!(:user_comment)    do
        create(:user_comment,
               commenter: commenter,
               commentable: user)
      end
      let!(:project_comment) do
        create(:project_comment,
               commenter: commenter,
               commentable: project)
      end

      it 'destroys when user was deleted' do
        expect { user.destroy }.to change(Comment, :count)
      end

      it 'destroys when project was deleted' do
      end

      it 'destroys when commenter was deleted' do
        expect { commenter.destroy }.to change(Comment, :count)
      end
    end
  end
end

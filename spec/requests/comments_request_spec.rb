require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user)       { create(:user) }
  let!(:commenter)  { create(:user) }
  let!(:project)    { create(:project, user: user) }
  

  describe 'User comments' do
    describe 'POST #create' do

      context 'as an authorized user' do
        it 'creates user_commtent' do
          sign_in commenter
          expect do
            post user_comments_path(user), params: { comment: attributes_for(:user_comment) }
          end.to change(Comment, :count).by(1)
        end
      end
\
      context 'as an unauthorized user' do
        it 'does not create user_comment' do
          expect do
            post user_comments_path(user), params: { comment: attributes_for(:user_comment) }
          end.not_to change(Comment, :count)
        end
      end

    end
  end


  describe 'Project comments' do
    describe 'POST #create' do

      context 'as an authorized user' do
        it 'creates project_comment' do
          sign_in commenter
          expect do
            post project_comments_path(project), params: { comment: attributes_for(:project_comment) }
          end.to change(Comment, :count).by(1)
        end
      end

      context 'as an unauthorized user' do
        it 'does not create project_comment' do
          expect do
            post project_comments_path(project), params: { comment: attributes_for(:project_comment) }
          end.not_to change(Comment, :count)
        end
      end
    end
  end

end

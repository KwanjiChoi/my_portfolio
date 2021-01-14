require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:project_notification) { create(:project_notification) }

  context 'project notification' do
    it 'has valid factory' do
      expect(project_notification).to be_valid
    end

    context 'notificatable_type' do
      it 'is invalid when type is nil' do
        project_notification.notificatable_type = nil
        expect(project_notification).not_to be_valid
      end
    end

    context 'visited' do
      it 'is invalid when visited is nil' do
        project_notification.visited = nil
        expect(project_notification).not_to be_valid
      end
    end

    context 'visitor' do
      it 'is invalid when visitor is nil' do
        project_notification.visitor = nil
        expect(project_notification).not_to be_valid
      end
    end

    context 'notificatable' do
      it 'is invalid when notificatable is nil' do
        project_notification.notificatable = nil
        expect(project_notification).not_to be_valid
      end
    end
  end

  # comment-user comment-projectをポリモーフィックに関連させているため
  # 少々ややこしいfactory構成になっている　要改善

  context 'comment fotification' do
    context 'comment for user' do
      let(:comment) { create(:user_comment) }
      let(:comment_notification) do
        create(:comment_notification,
               notificatable: comment,
               visitor: comment.commenter,
               visited: comment.commentable)
      end

      it 'has valid factory' do
        expect(comment_notification).to be_valid
      end

      context 'notificatable_type' do
        it 'is invalid when type is nil' do
          comment_notification.notificatable_type = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'visited' do
        it 'is invalid when visited is nil' do
          comment_notification.visited = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'visitor' do
        it 'is invalid when visitor is nil' do
          comment_notification.visitor = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'notificatable' do
        it 'is invalid when notificatable is nil' do
          comment_notification.notificatable = nil
          expect(comment_notification).not_to be_valid
        end
      end
    end

    context 'comment for project' do
      let(:comment) { create(:project_comment) }
      let(:comment_notification) do
        create(:comment_notification,
               notificatable: comment,
               visitor: comment.commenter,
               visited: comment.commentable.user)
      end

      it 'has valid factory' do
        expect(comment_notification).to be_valid
      end

      context 'notificatable_type' do
        it 'is invalid when type is nil' do
          comment_notification.notificatable_type = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'visited' do
        it 'is invalid when visited is nil' do
          comment_notification.visited = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'visitor' do
        it 'is invalid when visitor is nil' do
          comment_notification.visitor = nil
          expect(comment_notification).not_to be_valid
        end
      end

      context 'notificatable' do
        it 'is invalid when notificatable is nil' do
          comment_notification.notificatable = nil
          expect(comment_notification).not_to be_valid
        end
      end
    end
  end
end

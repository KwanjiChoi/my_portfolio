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

  context 'comment notification' do
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

  describe 'create notification' do
    let(:visited)      { create(:user) }
    let(:visitor)      { create(:user) }

    # commentable type
    let(:project)         { create(:project, user: visited) }
    let(:user_comment)    { create(:user_comment, commentable: visited, commenter: visitor) }
    let(:project_comment) { create(:project_comment, commentable: project, commenter: visitor) }
    let(:message)         { create(:message) }
    let(:reservation)     { create(:reservation, project: project, requester: visitor) }

    context 'to comment' do
      it 'for user' do
        expect do
          notification = user_comment.create_notification

          expect(notification.visitor).to eq visitor
          expect(notification.visited).to eq visited
        end.to change(Notification, :count).by(1)
      end

      it 'for project' do
        expect do
          notification = project_comment.create_notification

          expect(notification.visitor).to eq visitor
          expect(notification.visited).to eq visited
        end.to change(Notification, :count).by(1)
      end
    end

    context 'to message' do
      it 'successfully' do
        expect do
          message.create_notification
        end.to change(Notification, :count).by(1)
      end

      it 'unsuccessfully' do
        message.create_notification
        expect do
          message.create_notification
        end.not_to change(Notification, :count)
      end
    end

    context 'to reservation' do
      it 'successfully' do
        expect do
          reservation.create_notification
        end.to change(Notification, :count).by(1)
      end
    end
  end
end

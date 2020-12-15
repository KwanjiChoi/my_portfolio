require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'relation' do
    let!(:requester) { create(:user) }
    let!(:supplier)  { create(:user, teacher: true) }
    let!(:project)   { create(:project, user: supplier) }
    let!(:reservation) do
      create(:reservation, requester: requester, project: project)
    end
    let!(:room)            { create(:room, reservation: reservation) }
    let!(:requester_entry) { create(:entry,   room: room, user: requester) }
    let!(:supplier_entry)  { create(:entry,   room: room, user: supplier) }
    let!(:message)         { create(:message, room: room, user: requester) }

    context 'Room' do
      it 'dependent: :destroy requester' do
        expect { requester.destroy }.to   change(Room, :count)
      end
      it 'dependent: :destroy supplier' do
        expect { supplier.destroy }.to    change(Room, :count)
      end
      it 'dependent: :destroy project' do
        expect { project.destroy }.to     change(Room, :count)
      end
      it 'dependent: :destroy reservation' do
        expect { reservation.destroy }.to change(Room, :count)
      end
    end

    context 'Entry' do
      it 'dependent: :destroy room' do
        expect { room.destroy }.to change(Entry, :count)
      end
    end

    context 'Message' do
      it 'dependent: :destroy room' do
        expect { room.destroy }.to change(Message, :count)
      end
    end
  end

  describe 'validation' do
    let(:message) { build(:message) }

    it 'has valid factory' do
      expect(message).to be_valid
    end

    context 'content' do
      it 'is invalid when content is nil' do
        message.content = nil
        message.valid?
        expect(message.errors[:content]).to include "can't be blank"
      end

      it 'is invalid when content is blank' do
        message.content = '  '
        message.valid?
        expect(message.errors[:content]).to include "can't be blank"
      end

      it 'is invalid when content is over 255 characters' do
        message.content = 'a' * 256
        message.valid?
        expect(message.errors[:content]).to include 'is too long (maximum is 255 characters)'
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validation' do
    let(:reservation) { build(:reservation) }

    it 'has valid factory' do
      puts reservation.requester.username
      puts reservation.project.title
      expect(reservation).to be_valid
    end

    context 'requester_id' do
      it 'is invalid when requester_id is nil' do
        reservation.requester = nil
        puts reservation.valid?
        expect(reservation.errors[:requester]).to include 'must exist'
      end
    end

    context 'project_id' do
      it 'is invalid when project_id is nil' do
        reservation.project = nil
        puts reservation.valid?
        expect(reservation.errors[:project]).to include 'must exist'
      end
    end

    context 'start_at' do
      it 'is invalid when start_at is nil' do
        reservation.start_at = nil
        reservation.valid?
        expect(reservation.errors[:start_at]).to include "can't be blank"
      end

      it 'is invalid when start_at is before current time' do
        time = Time.current
        reservation.start_at = time - 1
        reservation.valid?
        expect(reservation.errors[:スタート時間]).to include "が過去になっています"
      end
    end

    context 'end_at' do
      it 'is valid when end_at is nil' do
        reservation.end_at = nil
        reservation.valid?
        expect(reservation.errors[:end_at]).not_to include "can't be blank"
      end

      it 'the diff between end_at and start_at should be multiple of 30min' do
        reservation.valid?
        diff = reservation.end_at - reservation.start_at
        expect(diff % 1800).to eq 0
      end
    end
  end

  describe 'relation' do
    let!(:user)        { create(:user) }
    let!(:project)     { create(:project) }
    let!(:reservation) { create(:reservation, project: project, requester: user) }

    context 'requester_id' do
      it 'dependent destroy' do
        expect { user.destroy }.to change(Reservation, :count)
      end
    end

    context 'project_id' do
      it 'dependent destroy' do
        expect { project.destroy }.to change(Reservation, :count)
      end
    end
  end
end

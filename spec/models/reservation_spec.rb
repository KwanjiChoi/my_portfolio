require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validation' do
    let(:reservation) { build(:reservation) }

    it 'has valid factory' do
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

  describe 'scope' do
    let!(:supplier)    { create(:user, :teacher_account) }
    let!(:requester)   { create(:user) }
    let!(:project)     { create(:project, user: supplier) }
    let!(:reservation) { create(:reservation, requester: requester, project: project) }

    context 'sort_reservations_by_status' do
      context 'from requester' do
        subject do
          Reservation.sort_reservations_by_status(
            requester, requester: true, status: 'reserved'
          )
        end

        it { is_expected.to include reservation }
        it do
          reservation.update_attributes(status: 'checked')
          is_expected.not_to include reservation
        end
      end

      context 'from project owner' do
        subject do
          Reservation.sort_reservations_by_status(supplier, supplier: true, status: 'reserved')
        end

        it { is_expected.to include reservation }
        it do
          reservation.update_attributes(status: 'checked')
          is_expected.not_to include reservation
        end
      end
    end
  end

  describe 'instance method' do
    start = Time.now.tomorrow
    let!(:reservation) { create(:reservation, start_at: start, reserve_time: 30) }

    context 'show_reserve_time' do
      it 'returns reserve time' do
        expect(reservation.show_reserve_time).to eq '30分'
      end
    end
  end
end

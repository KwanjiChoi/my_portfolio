require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it 'has a valid factory' do
    expect(@user).to be_valid
  end

  describe 'validations' do
    context 'username' do
      it 'is invalid without a username' do
        @user.username = nil
        @user.valid?
        expect(@user.errors[:username]).to include("can't be blank")
      end

      it 'is invalid when username length is within 2 characters' do
        @user.username = 'a'
        @user.valid?
        expect(@user.errors[:username]).to include("is too short (minimum is 2 characters)")
      end

      it 'is invalid when username length is over 50 characters' do
        @user.username = 'a' * 51
        @user.valid?
        expect(@user.errors[:username]).to include("is too long (maximum is 50 characters)")
      end

      it 'is invalid with a not unique username' do
        create(:user, username: 'otheruser')
        @user.username = 'otheruser'
        @user.valid?
        expect(@user.errors[:username]).to include("has already been taken")
      end

      # Validate length of username.
      it do
        expect(@user).to validate_length_of(:username).
          is_at_least(2).is_at_most(50)
      end
    end

    context 'email' do
      it 'is invalid without an email address' do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid with a not unique email address' do
        create(:user, email: "test@example.com")
        user = build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
    end

    context 'phone_number' do
      it 'is valid' do
        @user.phone_number = "09012345678"
        expect(@user).to be_valid
      end
      it 'is valid when nil' do
        @user.phone_number = nil
        expect(@user).to be_valid
      end
      it 'is invalid when blank' do
        @user.phone_number = '  '
        @user.valid?
        expect(@user.errors[:phone_number]).to include("type correct phone number")
      end
      it 'is invalid when not integer' do
        @user.phone_number = 'notinteger'
        @user.valid?
        expect(@user.errors[:phone_number]).to include("type correct phone number")
      end
      it 'is invalid within 9 letters' do
        @user.phone_number = '090000000'
        @user.valid?
        expect(@user.errors[:phone_number]).to include("type correct phone number")
      end
      it 'is invalid when over 11 letters' do
        @user.phone_number = '090000000000'
        @user.valid?
        expect(@user.errors[:phone_number]).to include("type correct phone number")
      end
      it 'is invalid phone_number already taken' do
        create(:user, phone_number: '09077777777')
        @user.phone_number = '09077777777'
        @user.valid?
        expect(@user.errors[:phone_number]).to include('has already been taken')
      end
    end
  end

  describe 'instance method' do
    context 'google map api methods' do
      include_examples 'googlemap api'
      it 'returns available number of addresses registrations' do
        expect(@user.available_addresses).to eq 5
        create_list(:address, 3, user: @user)
        expect(@user.available_addresses).to eq 2
      end
    end

    describe '' do
      let!(:user)      { create(:user, :teacher_account) }
      let!(:comment_1) { create(:user_comment, commentable: user, score: 1) }
      let!(:comment_2) { create(:user_comment, commentable: user, score: 5) }
      let!(:project)   { create(:project, user: user) }
      let!(:reservations) do
        create_list(:reservation, 10, project: project, status: 'finished')
      end

      context 'calculate_average_score' do
        subject { user.send(:calculate_average_score) }
        it      { is_expected.to eq 3 }
      end

      context 'get_finished_record' do
        subject { user.send(:get_finished_record) }
        it      { is_expected.to eq 10 }
      end
    end
  end
end

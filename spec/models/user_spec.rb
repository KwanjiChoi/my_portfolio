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

      it 'is invalid when username length is over 20 characters' do
        @user.username = 'a' * 21
        @user.valid?
        expect(@user.errors[:username]).to include("is too long (maximum is 20 characters)")
      end

      # Validate length of username.
      it do
        expect(@user).to validate_length_of(:username).
          is_at_least(2).is_at_most(20)
      end
    end

    context 'email' do
      it 'is invalid without an email address' do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid with a duplicate email address' do
        create(:user, email: "test@example.com")
        user = build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
    end
  end

  describe 'instance method' do
    it 'returns available number of addresses registrations' do
      expect(@user.available_addresses).to eq 5
      create_list(:address, 3, user: @user)
      expect(@user.available_addresses).to eq 2
    end
  end
end

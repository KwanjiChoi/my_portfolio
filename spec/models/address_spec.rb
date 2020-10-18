require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:user) { create(:user) }
  before do
    @address = build(:address)
  end

  it 'has a valid factory' do
    expect(@address).to be_valid
  end

  describe 'validation' do
    context 'address' do
      it 'is invalid without address' do
        @address.address = nil
        @address.valid?
        expect(@address.errors[:address]).to include("can't be blank")
      end

      it 'is invalid when address length is over 75 characters' do
        @address.address = 'a' * 76
        @address.valid?
        expect(@address.errors[:address]).to include("is too long (maximum is 75 characters)")
      end

      it 'is invalid when user create 6 address(max is 5)' do
        5.times do
          create(:address, user: user)
        end
        @address.user = user
        @address.valid?
        expect(@address.errors[:address]).to include("は最大5件まで登録できます")
      end

    end
  end

end

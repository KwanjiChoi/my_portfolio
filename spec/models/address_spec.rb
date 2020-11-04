require 'rails_helper'

RSpec.describe 'Address model', type: :model do
  let(:user) { create(:user) }

  before do
    @address = build(:address)
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "New York, NY", [
        {
          'latitude' => 40.7143528,
          'longitude' => -74.0059731,
        },
      ]
    )
    Geocoder::Lookup::Test.add_stub(
      'no meaning', []
    )
    Geocoder::Lookup::Test.add_stub(
      'a' * 76, []
    )
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
        create_list(:address, 5, user: user)
        @address.user = user
        @address.valid?
        expect(@address.errors[:address]).to include("の登録は最大5件までです")
      end
    end

    context 'using geocode' do
      it "is invalid when address doesn't make sence" do
        @address.address = 'no meaning'
        @address.valid?
        expect(@address.errors[:address]).to include("は無効な住所です")
      end
    end
  end

  describe 'scope' do
    context 'show_index' do
      subject { Address.show_index.to_sql }

      it { is_expected.to satisfy { |sql| sql.scan('ORDER BY `addresses`.`id` DESC').one? } }
      it { is_expected.to satisfy { |sql| sql.scan('DESC LIMIT 5').one? } }
    end
  end

  describe 'relation' do
    it 'dependent destroy' do
      user = create(:user)
      address = create(:address, user: user)
      expect { user.destroy }.to change(Address, :count)
    end
  end
end

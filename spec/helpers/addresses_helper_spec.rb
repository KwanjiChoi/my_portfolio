require 'rails_helper'

RSpec.describe AddressesHelper do
  context 'left_count' do
    it 'returns 最大件数登録済みです when argument is 0' do
      expect(left_count(0)).to eq "最大件数登録済みです"
    end
    it 'returns あと5件登録可能です when argument is 5' do
      expect(left_count(5)).to eq "あと5件登録可能です"
    end
  end
end

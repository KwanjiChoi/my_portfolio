require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  let!(:prefecture) { build(:prefecture) }

  it 'has valid factory' do
    expect(prefecture).to be_valid
  end
end

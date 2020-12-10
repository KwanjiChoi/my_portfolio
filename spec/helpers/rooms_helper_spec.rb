require 'rails_helper'

RSpec.describe RoomsHelper, type: :helper do
  describe 'parse_url' do
    it 'returns a hyper link' do
      text = 'https://www.google.com/'
      expect(parse_url(text)).to have_link
    end

    it 'returns a hyper link when text has many sentences' do
      text = <<-EOS
      こんにちは!
      こちらのカフェなんていかがでしょうか？
      https://www.google.com/
      とてもお洒落で居心地がいいです！
      EOS
      expect(parse_url(text)).to have_link
    end

    it 'does not return hyper link' do
      text = 'こんにちは'
      expect(parse_url(text)).not_to have_link
    end
  end
end

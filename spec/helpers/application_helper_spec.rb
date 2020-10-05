require 'rails_helper'

RSpec.describe ApplicationHelper do
  context 'page_title' do
    it 'returns sample_title - My Portfolio' do
      expect(page_title(title: 'sample_title')).to eq 'sample_title - My Portfolio'
    end

    it 'returns My Portfolio when argument is nil' do
      expect(page_title(title: nil)).to eq "My Portfolio"
    end

    it 'returns My Portfolio when argument is empty' do
      expect(page_title(title: '')).to eq "My Portfolio"
    end

    it 'returns My Portfolio when no argument' do
      expect(page_title).to eq "My Portfolio"
    end
  end
end
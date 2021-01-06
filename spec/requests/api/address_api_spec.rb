require "rails_helper"

describe 'AddressApi', type: :request do
  let(:response_body) do
    { "response": { "location": [
      { "city": "西宮市", "city_kana": "にしのみやし" },
      { "city": "尼崎市", "city_kana": "あまがさきし" },
    ] } }
  end

  before do
    WebMock.enable!

    uri = URI.encode("http://geoapi.heartrails.com/api/json?method=getCities&prefecture=兵庫県")
    WebMock.stub_request(
      :get, uri
    ).to_return(
      body: response_body.to_json,
      status: 200
    )
  end

  after { WebMock.disable! }

  context 'get_cities' do
    it 'returns Array' do
      expect(AddressApi.get_cities('兵庫県').class).to eq Array
    end
  end

  context 'cities' do
    it 'returns 2 cities' do
      expect(AddressApi.cities('兵庫県')).to eq ['西宮市', '尼崎市']
    end
  end
end

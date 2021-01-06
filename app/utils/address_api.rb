class AddressApi
  BASE_URL = 'http://geoapi.heartrails.com/api/json'.freeze

  def self.cities(pre)
    get_cities(pre).map { |city| city['city'] }
  end

  def self.get_cities(pre)
    uri = URI.parse(BASE_URL)
    params = {
      method: 'getCities',
      prefecture: pre,
    }
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    response = http.get(uri.request_uri)
    JSON.parse(response.body)['response']['location']
  end
end

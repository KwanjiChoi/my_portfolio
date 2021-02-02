puts 'Creating cities'

prefectures = [
  Prefecture.find(13),
  Prefecture.find(23),
  Prefecture.find(26),
  Prefecture.find(27),
  Prefecture.find(28),
  Prefecture.find(40),
]

prefectures.each do |pre|
  AddressApi.cities(pre.name).each do |city|
    pre.cities.create!(name: city)
  end
end
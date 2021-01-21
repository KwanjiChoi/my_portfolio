puts 'Creating cities'

Prefecture.all.each do |pre|
  AddressApi.cities(pre.name).each do |city|
    pre.cities.create!(name: city)
  end
end
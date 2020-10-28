shared_examples 'googlemap api' do
  before do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "New York, NY", [
        {
          'latitude' => 40.7143528,
          'longitude' => -74.0059731,
        },
      ],
    )

    Geocoder::Lookup::Test.add_stub(
      "Tokyo", [
        {
          'latitude' => 35.6761919,
          'longitude' => 139.6503106,
        },
      ],
    )

    Geocoder::Lookup::Test.add_stub(
      'meaningless address', []
    )
  end
end

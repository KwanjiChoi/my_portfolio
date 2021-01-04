FactoryBot.define do
  factory :project_location, class: 'Project::Location' do
    association :prefecture
    association :project
    address { '港区芝公園４丁目２−８' }
    station { 'JR浜松町駅' }
  end
end

FactoryBot.define do
  factory :project_location, class: 'Project::Location' do
    association :prefecture
    association :project
    association :city
    station { 'JR浜松町駅' }
  end
end

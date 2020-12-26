FactoryBot.define do
  factory :project_location, class: 'Project::Location' do
    association :prefecture
    association :project
  end
end

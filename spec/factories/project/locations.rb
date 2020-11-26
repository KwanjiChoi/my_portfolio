FactoryBot.define do
  factory :project_location, class: 'Project::Location' do
    prefecture_id { "28" }
    association   :project
  end
end

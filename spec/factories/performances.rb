FactoryBot.define do
  factory :user_performance, class: 'Performance' do
    association :performancable, factory: :user
    total_record { 0 }
    average_score { nil }
  end

  factory :project_performance, class: 'Performance' do
    association :performancable, factory: :project
    total_record  { 0 }
    average_score { nil }
  end
end

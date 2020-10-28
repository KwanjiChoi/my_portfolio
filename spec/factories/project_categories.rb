FactoryBot.define do
  factory :project_category do
    sequence(:name) { |n| "category-#{n}" }

    trait :invalid do
      name { nil }
    end
  end
end

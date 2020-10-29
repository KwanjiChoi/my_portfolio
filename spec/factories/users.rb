FactoryBot.define do
  factory :user, aliases: [:owner] do
    sequence(:username) { |n| "Testuser#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    # https://qiita.com/xusaku_/items/018cf2cb9caae8b5fb8b
    confirmed_at { Date.today }

    trait :sample_user do
      email { 'tester@example.com' }
    end

    trait :system_user do
      username  { 'SampleUser' }
      email     { 'sample@example.com'}
    end

    trait :teacher_account do
      username  { 'SampleUser' }
      email     { 'sample@example.com'}
      teacher { true }
    end
  end
end

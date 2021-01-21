FactoryBot.define do
  factory :user, aliases: [:owner] do
    sequence(:username) { |n| "Testuser#{n}" }
    sequence(:email)    { |n| "tester#{n}@example.com" }
    password            { 'password' }
    phone_number        { "0#{rand(0..9)}0#{rand(1_000_000..99_999_999)}" }
    # https://qiita.com/xusaku_/items/018cf2cb9caae8b5fb8b
    confirmed_at        { Date.today }
    introduction        { 'こんにちは、よろしくお願いいたします！' }

    trait :sample_user do
      email { 'tester@example.com' }
    end

    trait :system_user do
      username  { 'SampleUser' }
      email     { 'sample@example.com' }
    end

    trait :teacher_account do
      username  { 'SampleUser' }
      email     { 'sample@example.com' }
      teacher   { true }

      after(:create) do |user|
        create(:user_performance, performancable: user)
      end
    end
  end
end

FactoryBot.define do
  factory :address do
    address { "東京都港区芝公園４丁目２−８" }
    association :user
  end

  trait :invalid do
    address { '' }
  end
end

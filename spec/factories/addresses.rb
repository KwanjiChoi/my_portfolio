FactoryBot.define do
  factory :address do
    address { "New York, NY"}
    association :user
  end

  trait :invalid do
    address { '' }
  end

end

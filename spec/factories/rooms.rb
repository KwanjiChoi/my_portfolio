FactoryBot.define do
  factory :room do
    association :reservation
  end
end

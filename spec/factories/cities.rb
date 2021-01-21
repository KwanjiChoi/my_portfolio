FactoryBot.define do
  factory :city do
    name { "The City" }
    association :prefecture
  end
end

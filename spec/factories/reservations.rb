FactoryBot.define do
  factory :reservation do
    association :project
    association :requester, factory: :user
    request_text { 'よろしくお願いいたします' }
    start_at     { Time.parse("18:00") }
    reserve_time { 60 }
  end
end

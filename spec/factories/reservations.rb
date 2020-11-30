FactoryBot.define do
  factory :reservation do
    association :project
    association :requester, factory: :user
    request_text { 'よろしくお願いいたします' }
    start_at     { Time.now.tomorrow }
    reserve_time { 60 }
  end
end

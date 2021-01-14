FactoryBot.define do
  factory :project_notification, class: 'Notification' do
    association :notificatable, factory: :project, strategy: :build
    notificatable_type { 'Project' }

    visited { notificatable.user }
    association :visitor, factory: :user, strategy: :build
  end

  factory :comment_notification, class: 'Notification' do
    association :notificatable, factory: :comment, strategy: :build
    notificatable_type { 'Comment' }

    association :visited, factory: :user, strategy: :build
    association :visitor, factory: :user, strategy: :build
  end
end

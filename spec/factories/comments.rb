FactoryBot.define do
  factory :user_comment, class: 'Comment' do
    association :commenter,   factory: :user
    association :commentable, factory: :user
    commentable_type { 'User' }
    comment          { 'Sample Comment' }
    score            { 5 }
  end

  factory :project_comment, class: 'Comment' do
    association :commenter,   factory: :user
    association :commentable, factory: :project
    commentable_type { 'Project' }
    comment          { 'Sample Comment' }
    score            { 5 }
  end
end

FactoryBot.define do
  Comment_Type = [:user, :project].freeze

  Comment_Type.each do |type|
    factory :"#{type}_comment", class: 'Comment' do
      association :commenter,   factory: :user
      association :commentable, factory: type
      commentable_type { type.to_s.camelize }
      comment          { 'Sample Comment' }
      score            { 5 }
    end
  end
end

class Comment < ApplicationRecord
  SCORE_VALUES = [1, 2, 3, 4, 5].freeze

  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'

  has_many :notifications, as: :notificatable, dependent: :destroy

  validates :comment, presence: true
  validates :score,   presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
  }

  def create_notification
    case commentable_type
    when 'User'
      notifications.create(visitor: commenter,
                           visited: commentable)
    when 'Project'
      notifications.create(visitor: commenter,
                           visited: commentable.user)
    end
  end
end

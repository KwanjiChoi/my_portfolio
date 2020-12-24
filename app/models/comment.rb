class Comment < ApplicationRecord
  SCORE_VALUES = [1, 2, 3, 4, 5].freeze

  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'

  validates :comment, presence: true
  validates :score,   presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
  }
end

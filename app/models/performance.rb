class Performance < ApplicationRecord
  belongs_to :performancable, polymorphic: true

  validates :total_record, presence: true
  validates :average_score, allow_nil: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
  }
end

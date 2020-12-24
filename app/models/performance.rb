class Performance < ApplicationRecord
  belongs_to :performancable, polymorphic: true
end

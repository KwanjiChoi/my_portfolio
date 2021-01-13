class City < ApplicationRecord
  belongs_to :prefecture
  has_many   :project_locations
end

class Project::Location < ApplicationRecord
  belongs_to :prefecture, foreign_key: "prefecture_id"
  belongs_to :project
end

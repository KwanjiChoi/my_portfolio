class Project::Location < ApplicationRecord
  belongs_to :prefecture, foreign_key: "prefecture_id"
  belongs_to :project

  validates :address, presence: true, length: { in: 2..50 }
end

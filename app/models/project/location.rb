class Project::Location < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :project

  validates :prefecture_id, presence: true
end

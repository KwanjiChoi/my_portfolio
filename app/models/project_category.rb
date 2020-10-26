class ProjectCategory < ApplicationRecord
  has_one :project

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

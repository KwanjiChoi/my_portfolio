class ProjectCategory < ApplicationRecord
  has_many :project

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

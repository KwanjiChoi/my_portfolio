class Prefecture < ApplicationRecord
  has_many :project_locations

  scope :area_1, -> { where(id: [1..7]) }
  scope :area_2, -> { where(id: [8..20]) }
  scope :area_3, -> { where(id: [21..24]) }
  scope :area_4, -> { where(id: [25..35]) }
  scope :area_5, -> { where(id: [36..47]) }
end

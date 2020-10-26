class Project < ApplicationRecord
  belongs_to :user
  belongs_to :project_category

  mount_uploader :main_image, ImageUploader

  validates :main_image, presence: true
  validates :title,      presence: true, length: { in: 2..50 }
  validates :content,    presence: true, length: { maximum: 1000 }

  has_rich_text :content
end

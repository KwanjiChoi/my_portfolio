class Project < ApplicationRecord
  belongs_to :user
  belongs_to :project_category

  mount_uploader :main_image, ImageUploader

  validates :main_image, presence: true
  validates :title,      presence: true, length: { in: 2..50 }
  validates :content,    presence: true, length: { in: 100..2000 }

  has_rich_text :content

  # https://qiita.com/QUANON/items/ae47ae23c572d498050d
  delegate :strip_tags, to: 'ApplicationController.helpers'

  def category_name
    project_category.name
  end

  def owner
    user.username
  end

  def short_content
    strip_tags(content.to_s).gsub(/[\n]/,"").strip[0..29] + '...'
  end
end

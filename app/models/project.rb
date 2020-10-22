class Project < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 2..50 }
  validates :text,  presence: true


  has_rich_text :content
end

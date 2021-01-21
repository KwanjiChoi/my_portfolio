class Project < ApplicationRecord
  include Calculator
  RECENT_COUNT = 6

  belongs_to :user
  belongs_to :project_category

  scope :recent_projects, -> {
    order(id: :desc).limit(RECENT_COUNT)
  }

  has_many :reservations,  dependent: :destroy
  has_many :comments,      as: :commentable,   dependent: :destroy
  has_many :notifications, as: :notificatable, dependent: :destroy

  mount_uploader :main_image, ImageUploader

  validates :main_image,    presence: true
  validates :title,         presence: true, length: { in: 2..50 }
  validates :content,       presence: true, length: { in: 100..2000 }
  validate  :check_phone_reservation

  has_one :location, class_name: 'Project::Location', dependent: :destroy
  has_one :performance, as: :performancable, dependent: :destroy

  accepts_nested_attributes_for :location, allow_destroy: true

  has_rich_text :content

  # https://qiita.com/QUANON/items/ae47ae23c572d498050d
  delegate :strip_tags, to: 'ApplicationController.helpers'
  delegate :username,   to: :user

  alias_method :owner,    :username
  alias_method :supplier, :user

  def category_name
    project_category.name
  end

  def location_name
    "#{location&.prefecture&.name} #{location&.city&.name}"
  end

  def short_content
    # .includes([:rich_text_content])
    strip_tags(content.to_s).gsub(/[\n]/, "").strip[0..75] + '...'
  end

  private

  def check_phone_reservation
    if phone_reservation == true
      errors.add(:phone_reservation, "電話予約を設定するには電話番号の登録が必要です") if user.phone_number.blank?
    end
  end

  def get_finished_record
    reservations.where(status: 'finished').size
  end
end

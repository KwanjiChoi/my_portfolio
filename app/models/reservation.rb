class Reservation < ApplicationRecord
  RESERVE_TIME = { "30分": 30, '60分': 60, '90分': 90, "120分": 120 }.freeze

  attr_accessor :reserve_time

  belongs_to :requester, class_name: 'User'
  belongs_to :project

  has_many :rooms, dependent: :destroy

  delegate :supplier, to: :project

  validates :start_at,     presence: true
  validates :reserve_time, presence: true

  validate  :check_start_at

  before_validation :set_end_at

  scope :sort_reservations_by_status, -> (user, requester: false, supplier: false, status:) {
    if requester == true
      order(created_at: :asc).where(requester_id: user.id, status: status).includes(project: :user)
    elsif supplier == true
      user.passive_reservations.order(created_at: :asc).
        where(status: status).includes([:requester, :project])
    end
  }

  enum status: {
    unchecked: 0,
    checked: 1,
    finished: 2,
    canceled: 3,
  }

  def owner_name
    project.owner
  end

  def show_reserve_time
    "#{((end_at - start_at) / 60).to_i}分"
  end

  def create_chat_room
    room = rooms.create
    room.entries.create(user: requester)
    room.entries.create(user: supplier)
    room.messages.create(user: supplier, content: '予約を受け付けました！ 確認まで少々お待ちください。')
  end

  def update_status(status)
    update_attribute(:status, status)
  end

  private

  def set_end_at
    return if start_at.nil?
    self.end_at = start_at + reserve_time.to_i * 60
  end

  def check_start_at
    return if start_at.nil?
    if start_at - Time.current < 0
      errors.add(:スタート時間, 'が過去になっています')
    end
  end
end

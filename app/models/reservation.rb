class Reservation < ApplicationRecord
  RESERVE_TIME = { "30分": 30, '60分': 60, '90分': 90, "120分": 120 }.freeze

  attr_accessor :reserve_time

  belongs_to :requester, class_name: 'User'
  belongs_to :project

  validates :start_at,     presence: true
  validates :reserve_time, presence: true

  validate  :check_start_at

  before_validation :set_end_at

  enum status: {
    reserved: 0,
    checked: 1,
    finished: 2,
    cancelled: 3,
  }

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

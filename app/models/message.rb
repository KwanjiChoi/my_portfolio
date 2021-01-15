class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: { maximum: 255 }

  def create_notification
    room.notifications.find_or_create_by(
      visitor: user, visited: room.opponent(user), checked: false
    )
  end
end

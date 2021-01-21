class UserDecorator < ApplicationDecorator
  delegate_all

  def unchecked_notifications_count
    unchecked_notifications.size
  end

  def has_unchecked_notifications?
    unchecked_notifications.exists?
  end

  private

  def unchecked_notifications
    @notifications ||= object.passive_notifications.where(checked: false)
  end
end

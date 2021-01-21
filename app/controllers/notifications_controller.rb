class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def index
    current_user.passive_notifications.
      where(checked: false).update_all(checked: true)

    @notifications = current_user.
      passive_notifications.preload(:notificatable, :visitor, :visited).
      order(created_at: 'DESC').decorate
  end

  private

  def correct_user
    redirect_to root_path unless current_user == User.find(params[:user_id])
  end
end

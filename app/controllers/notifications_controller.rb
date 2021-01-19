class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def index
    @notifications = current_user.passive_notifications
  end

  private

  def correct_user
    redirect_to root_path unless current_user == User.find(params[:user_id])
  end

end
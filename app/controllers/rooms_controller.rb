class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_users, only: [:show]

  def room
    @room ||= Room.find(params[:id])
  end

  def messages
    Message.where(room: room)
  end

  helper_method :room, :messages

  def show; end

  def index
  end

  private

  def correct_users
    redirect_to root_path if room.mate?(current_user)
  end
end

class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_users, only: [:show]

  let(:room)     { Room.find(params[:id]) }
  let(:messages) { Message.where(room: room).includes([:user]) }

  def show
    @message = Message.new
  end

  def index; end

  private

  def correct_users
    redirect_to root_path unless room.mate?(current_user)
  end
end

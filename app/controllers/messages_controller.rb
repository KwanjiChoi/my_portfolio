class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.create(message_params)
    respond_to do |format|
      if @message.save
        format.js
      else
        room = @message.room
        messages = Message.where(room: room).includes([:user])
        format.html { render 'rooms/show', locals: { room: room, messages: messages } }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content)
  end
end


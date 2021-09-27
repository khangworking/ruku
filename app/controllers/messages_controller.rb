class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      @message.broadcast_to_other(current_user.id)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('input_message_body', partial: 'messages/form', locals: { message: Message.new(chat_room_id: @message.chat_room_id) }),
            turbo_stream.after('new_messages', partial: 'messages/current_user_message', locals: { message: @message })
          ]
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('input_message_body', partial: 'messages/error_message')
        end
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:chat_room_id, :body).tap do |whitelist|
      whitelist[:user_id] = current_user.id
    end
  end
end
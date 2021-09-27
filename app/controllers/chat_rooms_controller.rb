class ChatRoomsController < ApplicationController
  layout "blank"
  before_action :authenticate_user!

  def index
    @chat_rooms = current_user.chat_room_users.includes(chat_room: %i[latest_message users]).order(created_at: :desc)
    @new_chat_room = new_chat_room
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    respond_to do |format|
      if @chat_room.save
        format.html { redirect_to @chat_room, notice: "Room was successfully created." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("chat_room_form", partial: 'chat_rooms/form', locals: { new_chat_room: new_chat_room, user: current_user })
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.includes(:user).page(1).per(25)
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    chat_room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name, chat_room_users_attributes: [:user_id])
  end

  def new_chat_room
    ChatRoom.new(chat_room_users: [
      ChatRoomUser.new(user_id: current_user.id),
      ChatRoomUser.new
    ])
  end
end
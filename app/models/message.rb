# == Schema Information
#
# Table name: messages
#
#  id           :bigint(8)        not null, primary key
#  chat_room_id :bigint(8)
#  user_id      :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  body         :text
#
# Indexes
#
#  index_messages_on_chat_room_id  (chat_room_id)
#  index_messages_on_user_id       (user_id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # after_create_commit -> do
  #   broadcast_action_later_to [:chat_room, chat_room_id], partial: 'messages/other_user_message', locals: { message: self }, action: :after, target: :new_messages
  # end

  def broadcast_to_other(ignore_user_ids = [])
    chat_room.users.where.not(id: Array(ignore_user_ids)).each do |user|
      broadcast_action_later_to(
        [:chat_room, chat_room_id, :user, user.id], 
        partial: 'messages/other_user_message', 
        locals: { message: self },
        action: :after,
        target: :new_messages
      )
    end
  end
end

# == Schema Information
#
# Table name: chat_room_users
#
#  id           :bigint(8)        not null, primary key
#  user_id      :bigint(8)
#  chat_room_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_chat_room_users_on_chat_room_id  (chat_room_id)
#  index_chat_room_users_on_user_id       (user_id)
#
class ChatRoomUser < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create_commit -> { broadcast_action_later_to [:chat_rooms, user_id], locals: { user: user }, action: :prepend, target: :room_list }
  after_destroy_commit -> { broadcast_remove_to [:chat_rooms, user_id] }
end

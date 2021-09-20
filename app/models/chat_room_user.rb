# == Schema Information
#
# Table name: chat_room_users
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  chat_room_id :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ChatRoomUser < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create_commit -> { broadcast_action_later_to [:chat_rooms, self.user_id], action: :prepend, target: :room_list }
  after_destroy_commit -> { broadcast_remove_to [:chat_rooms, self.user_id] }
end

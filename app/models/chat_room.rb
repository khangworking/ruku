# == Schema Information
#
# Table name: chat_rooms
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users
  has_many :messages, -> { order(id: :desc) }
  has_one :latest_message, -> { order(id: :desc) }, class_name: Message.to_s

  accepts_nested_attributes_for :chat_room_users, reject_if: :all_blank

  before_validation :set_default

  def chatting_with(from_user)
    users.find { |user| from_user.id != user.id }
  end

  private

  def set_default
    self.name ||= 'private room'
  end
end

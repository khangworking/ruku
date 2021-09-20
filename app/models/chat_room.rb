# == Schema Information
#
# Table name: chat_rooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  accepts_nested_attributes_for :chat_room_users, reject_if: :all_blank

  before_validation :set_default

  private

  def set_default
    self.name ||= 'private room'
  end
end

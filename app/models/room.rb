# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  broadcasts_to ->(room) { :rooms }, inserts_by: :prepend, target: 'rooms_list'

  def duration
    (Time.zone.now - created_at).to_i
  end
end

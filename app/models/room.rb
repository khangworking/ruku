class Room < ApplicationRecord
  broadcasts_to ->(room) { :rooms }, inserts_by: :prepend, target: 'rooms_list'

  def duration
    (Time.zone.now - created_at).to_i
  end
end

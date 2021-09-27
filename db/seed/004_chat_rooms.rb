sender = User.find_by email: 'admin@admin.com'
receivers = User.where.not(email: 'admin@admin.com')

receivers.each do |receiver|
  ChatRoom.create(name: Faker::Name.name, chat_room_users_attributes: [
    { user_id: sender.id },
    { user_id: receiver.id }
  ])
end
ChatRoom.includes(:users).each do |cr|
  Faker::Number.number(digits: 2).times do
    sender = cr.users.sample
    cr.messages.create!(body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 3), user_id: sender.id)
  end
end
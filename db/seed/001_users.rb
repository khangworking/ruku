emails = %w[admin@admin.com user1@user.com user2@user.com user3@user.com user4@user.com]
emails.each do |email|
  user = User.find_or_initialize_by(email: email)
  user.password = 'password'
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.save!
end
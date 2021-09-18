emails = %w[admin@admin.com]
emails.each do |email|
  user = User.find_or_initialize_by(email: email)
  user.password = 'password'
  user.save!
end
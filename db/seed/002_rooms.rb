100.times do
  Room.create(name: Faker::Name.name, status: %w[running pausing stopped].sample, created_at: (1..5).to_a.sample.hours.ago)
end
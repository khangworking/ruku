Dir[Rails.root.join('db/seed/*.rb')].sort.each do |file|
  puts "Processing #{file.split('/').last}"
  require file
end
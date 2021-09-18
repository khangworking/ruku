1000.times do
  Product.create(name: Faker::Name.name, status: 'Sale Off', active: true)
end
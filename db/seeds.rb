# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Faker::Config.locale = 'fr'


Meal.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('meals')

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')



10.times do
   User.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.sentence(word_count: 10),
      email: Faker::Internet.safe_email,
      age: rand(18..100),
      password: "123456",
      gender: Faker::Gender.type,
      city: Faker::Address.city
   )
end

10.times do
   Category.create(label: Faker::Food.ethnic_category)
end

20.times do 
   Meal.create!(
      title: Faker::Quote.singular_siegler,
      description: Faker::Food.description,
      price: rand(1.1...99.87),
      guest_capacity: rand(1..9),
      guest_registered: rand(1..9),
      starting_date: Faker::Date.between(from: Date.today, to: '2022-12-25'),
      location: {city: Faker::Address.city, lat: Faker::Address.latitude, lon: Faker::Address.longitude, address: Faker::Address.full_address},
      host: User.find(rand(1..10)),
      animals: [true, false].sample,
      alcool: [true, false].sample,
      doggybag: [true, false].sample,
      diet_type: ["vegan", "vegetarien", "vegetalien", "omnivore", "crudivore", "flexitarien"].sample(rand(1..3)),
      theme: Faker::Food.ethnic_category,
      allergens: ["gluten", "lactose", "soy", "nuts", "shellfish"].sample(rand(1..5))
   )
end

Meal.all.each do |meal|
   n = rand(1..3)
   n.times do
      JoinCategoryMeal.create!(
         meal: meal,
         category: Category.all.sample
      )
   end
end

Meal.all.each do |meal|
   n = rand(1..5)
   n.times do 
      Attendance.create!(
         guest: User.all.sample,
         meal: meal         
      )
   end
end







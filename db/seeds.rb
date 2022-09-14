# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Faker::Config.locale = 'fr'



JoinCategoryMeal.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('join_category_meals')

Attendance.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('attendances')

Meal.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('meals')

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')

Category.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('categories')



10.times do
   User.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.sentence(word_count: 10),
      email: Faker::Internet.safe_email,
      age: rand(18..98),
      password: "123456",
      gender: Faker::Gender.type,
      city: Faker::Address.city
   )
end

catArray = ["Japanese", "SeaFood", "Drink", "Meat", "Vege", "Fruits", "Mexican", "Belgium", "Pizza"]

catArray.each do |cat|
   Category.create(label: cat)
end

20.times do 
   Meal.create!(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      price: rand(2...24),
      guest_capacity: rand(1..11),
      guest_registered: rand(1..9),
      starting_date: Faker::Date.between(from: (Date.today), to: '2022-12-25'),
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
   n = rand(2..3)
   n.times do
      JoinCategoryMeal.create!(
         meal: meal,
         category: Category.all.sample
      )

   end
   meal.categories = meal.categories.uniq
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







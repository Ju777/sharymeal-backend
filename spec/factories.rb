FactoryBot.define do
    factory :meal do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.paragraph }
      price {rand(1...24)}
      guest_capacity {rand(1..11)}
      guest_registered {rand(1..11)}
      starting_date {Faker::Time.between_dates(from: Date.today, to: Date.today + 60, period: :all)}
    #   location {city: Faker::Address.city, lat: Faker::Address.latitude, lon: Faker::Address.longitude, address: Faker::Address.full_address}
      host {User.first}
      animals {[true, false].sample}
      alcool {[true, false].sample}
      doggybag {[true, false].sample}
      diet_type {["vegan", "vegetarien", "vegetalien", "omnivore", "crudivore", "flexitarien"].sample(rand(1..3))}
      theme {Faker::Food.ethnic_category}
      allergens {["gluten", "lactose", "soy", "nuts", "shellfish"].sample(rand(1..5))}
    end
  end

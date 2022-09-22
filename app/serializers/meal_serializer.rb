class MealSerializer
  include JSONAPI::Serializer
  attributes  :id, :image_urls, :created_at ,:categories, :host, :title, :description, :price, :guest_capacity, :guest_registered, :starting_date, :location, :animals, :alcool, :doggybag, :theme, :allergens, :diet_type
end

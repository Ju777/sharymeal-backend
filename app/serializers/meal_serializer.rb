class MealSerializer
  include JSONAPI::Serializer
  attributes  :image_urls, :host
end

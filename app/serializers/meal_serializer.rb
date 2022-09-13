class MealSerializer
  include JSONAPI::Serializer
  attributes :image, :image_url, :host
end

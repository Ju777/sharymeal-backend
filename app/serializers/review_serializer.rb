class ReviewSerializer
  include JSONAPI::Serializer
  attributes  :id, :author,  :content, :created_at, :rating, :host
end
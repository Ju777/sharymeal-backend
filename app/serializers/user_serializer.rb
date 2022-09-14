class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :avatar, :avatar_url, :hosted_meals, :name, :description, :city, :age, :gender
end
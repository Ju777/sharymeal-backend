class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :avatar, :avatar_url, :hosted_meals
end
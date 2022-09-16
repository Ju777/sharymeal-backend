class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :avatar, :avatar_url, :name, :description, :city, :age, :gender

end
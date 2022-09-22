class MessageSerializer
  include JSONAPI::Serializer
  attributes  :id, :sender, :recipient, :content, :created_at
end
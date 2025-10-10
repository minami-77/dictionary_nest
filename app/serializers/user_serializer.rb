# Serializer for User instance
class UserSerializer
  include JSONAPI::Serializer

  # Extract attributes which pass to frontend as json API
  attributes :id, :email, :name
end

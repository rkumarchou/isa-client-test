class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :api_token

  def api_token
    object.private_api_key
  end
end

class AccountSerializer < ActiveModel::Serializer
  attributes :id, :service, :username, :user_id
end

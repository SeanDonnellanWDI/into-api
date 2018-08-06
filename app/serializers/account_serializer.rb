class AccountSerializer < ActiveModel::Serializer
  attributes :id, :service, :username
end

class AccountSerializer < ActiveModel::Serializer
  attributes :id, :service, :username, :editable, :user_id

  def editable
    scope == object.user
  end
end

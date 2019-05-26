class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :payments
  has_many :dogs, through: :payments

end

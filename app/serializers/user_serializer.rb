class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :payment_info

  has_many :payments
  has_many :dogs, through: :payments
end

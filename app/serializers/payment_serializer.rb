class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :note

  belongs_to :user
  belongs_to :dog
end

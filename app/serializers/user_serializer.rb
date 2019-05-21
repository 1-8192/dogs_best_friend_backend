class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :payment_info

  has_many :payments
  has_many :dogs, through: :payments

  def total_payments
    new_array = self.payments.map { |payment| payment.amount.to_f}
    return new_array.reduce(0, :+)
  end
  
end

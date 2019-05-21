class Dog < ApplicationRecord
  belongs_to :shelter
  has_many :payments
  has_many :users, -> { distinct }, through: :payments

  def total_payments
    new_array = self.payments.map { |payment| payment.amount.to_f}
    return new_array.reduce(0, :+)
  end
end

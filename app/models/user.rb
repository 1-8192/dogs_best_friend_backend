class User < ApplicationRecord
  has_secure_password

  has_many :payments
  has_many :dogs, -> { distinct }, through: :payments

  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  def total_payments
    new_array = self.payments.map { |payment| payment.amount.to_f}
    return new_array.reduce(0, :+)
  end

end

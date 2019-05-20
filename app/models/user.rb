class User < ApplicationRecord
  has_secure_password

  has_many :payments
  has_many :dogs, through: :payments

  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

end

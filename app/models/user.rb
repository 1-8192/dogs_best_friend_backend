class User < ApplicationRecord
  has_many :payments
  has_many :dogs, through: :payments
end

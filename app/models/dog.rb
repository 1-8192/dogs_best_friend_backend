class Dog < ApplicationRecord
  belongs_to :shelter
  has_many :payments
  has_many :users, through: :payments
end

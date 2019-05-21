class DogSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :chip_id, :sex, :breed, :age, :is_vaccinated, :at_risk, :shelter_id

  belongs_to :shelter
  has_many :payments
  has_many :users, through: :payments

  def total_payments
    new_array = self.payments.map { |payment| payment.amount.to_f}
    return new_array.reduce(0, :+)
  end
  
end

class DogSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :chip_id, :sex, :breed, :age, :is_vaccinated, :at_risk, :shelter_id

  belongs_to :shelter
  has_many :payments
  has_many :users, through: :payments
end

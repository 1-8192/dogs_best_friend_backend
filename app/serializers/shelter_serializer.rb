class ShelterSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :contact

  has_many :dogs
end

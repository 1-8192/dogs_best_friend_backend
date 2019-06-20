require 'rails_helper'

describe Shelter, type: :model do
  let(:attributes) do
    {
      name: "Furry Friends",
      location: "1600 Pennsylvania Avenue",
      contact: "1-800-456-7896"
    }
  end

  it "is considered valid" do
    expect(Shelter.new(attributes)).to be_valid
  end
end
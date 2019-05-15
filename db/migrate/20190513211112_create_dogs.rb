class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :image_url
      t.string :chip_id
      t.string :sex
      t.string :breed, :default => "mix"
      t.string :age
      t.boolean :is_vaccinated, :default => true
      t.boolean :at_risk, :default => false
      t.belongs_to :shelter

      t.timestamps
    end
  end
end

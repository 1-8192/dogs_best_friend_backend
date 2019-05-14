class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :image_url
      t.integer :chip_id
      t.string :sex
      t.string :breed, :default => "mix"
      t.string :age
      t.string :weight
      t.boolean :is_vaccinated, :default => true
      t.boolean :at_risk, :default => false
      t.string :intake_date, :default => "N/A"
      t.belongs_to :shelter

      t.timestamps
    end
  end
end

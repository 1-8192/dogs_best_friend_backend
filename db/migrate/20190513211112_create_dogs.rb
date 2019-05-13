class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.boolean :at_risk, :default => false
      t.belongs_to :shelter

      t.timestamps
    end
  end
end

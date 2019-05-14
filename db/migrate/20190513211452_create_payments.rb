class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :note
      t.belongs_to :user
      t.belongs_to :dog

      t.timestamps
    end
  end
end

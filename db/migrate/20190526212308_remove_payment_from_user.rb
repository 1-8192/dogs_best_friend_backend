class RemovePaymentFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :payment_info
  end
end

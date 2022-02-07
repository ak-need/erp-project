class AddModeOfPaymentToPurchasedItem < ActiveRecord::Migration[5.2]
  def change
    add_column :purchased_items, :mode_of_payment, :string
  end
end

class CreatePurchasedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_items do |t|
      t.string :item_name
      t.float :item_price
      t.string :item_barcode
      t.string :purchased_from
      t.integer :quantity

      t.timestamps
    end
  end
end

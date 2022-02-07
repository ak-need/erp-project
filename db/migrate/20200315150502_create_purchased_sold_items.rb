class CreatePurchasedSoldItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_sold_items do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :barcode
      t.string :category

      t.timestamps
    end
  end
end

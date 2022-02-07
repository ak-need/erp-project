class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku_no
      t.string :category
      t.string :barcode
      t.integer :quantity
      t.float :base_price
      t.float :sale_price
      t.float :gst_percentage
      t.float :cost
      t.string :hsn_code
      t.references :vendor, foreign_key: true

      t.timestamps
    end
  end
end

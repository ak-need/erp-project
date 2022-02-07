class CreateVendorAmounts < ActiveRecord::Migration[5.2]
  def change
    create_table :vendor_amounts do |t|
      t.integer :quantity
      t.float :sold_amount
      t.string :gst
      t.float :tax_percentage
      t.float :vendor_amount
      t.float :tax_amount
      t.references :product, foreign_key: true
      t.references :vendor, foreign_key: true

      t.timestamps
    end
  end
end

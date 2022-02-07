class CreateSoldProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :sold_products do |t|
      t.integer :quantity
      t.float :sold_amount
      t.string :gst
      t.references :sale, foreign_key: true

      t.timestamps
    end
  end
end

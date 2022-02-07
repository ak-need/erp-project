class CreateKitchens < ActiveRecord::Migration[5.2]
  def change
    create_table :kitchens do |t|
      t.string :item_name
      t.integer :price

      t.timestamps
    end
  end
end

class AddCategoryToPurchasedItem < ActiveRecord::Migration[5.2]
  def change
    add_column :purchased_items, :category, :string
  end
end

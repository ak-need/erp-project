class AddTotalValueToPurchasedSoldItems < ActiveRecord::Migration[5.2]
  def change
    add_column :purchased_sold_items, :total_value, :float
  end
end

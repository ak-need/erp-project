class AddTotalPriceToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :total_price, :float
  end
end

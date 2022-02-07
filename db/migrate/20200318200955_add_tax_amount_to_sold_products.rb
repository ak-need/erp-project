class AddTaxAmountToSoldProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :sold_products, :tax_amount, :float
  end
end

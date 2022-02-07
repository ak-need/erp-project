class AddTaxPercentageToSoldProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :sold_products, :tax_percentage, :float
  end
end

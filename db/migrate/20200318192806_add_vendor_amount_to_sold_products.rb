class AddVendorAmountToSoldProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :sold_products, :vendor_amount, :float
  end
end

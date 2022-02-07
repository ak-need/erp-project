class AddVendorToSoldProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :sold_products, :vendor, foreign_key: true
  end
end

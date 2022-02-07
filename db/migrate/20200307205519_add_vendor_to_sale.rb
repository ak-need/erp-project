class AddVendorToSale < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales, :vendor, foreign_key: true
  end
end

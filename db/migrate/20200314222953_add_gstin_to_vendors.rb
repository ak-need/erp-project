class AddGstinToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :gstin, :string
  end
end

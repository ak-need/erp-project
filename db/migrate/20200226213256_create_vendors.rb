class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end

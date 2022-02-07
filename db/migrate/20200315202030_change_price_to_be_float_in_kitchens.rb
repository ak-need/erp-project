class ChangePriceToBeFloatInKitchens < ActiveRecord::Migration[5.2]
  def change
    change_column :kitchens, :price, :float
  end
end

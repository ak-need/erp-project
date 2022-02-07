class RemoveSaleFromSoldProduct < ActiveRecord::Migration[5.2]
  def change
    remove_reference :sold_products, :sale, foreign_key: true
  end
end

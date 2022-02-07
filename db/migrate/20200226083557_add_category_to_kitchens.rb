class AddCategoryToKitchens < ActiveRecord::Migration[5.2]
  def change
    add_column :kitchens, :category, :string
  end
end

class AddModuleAllergensToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :module_allergens, :boolean, :default => false
  end
end

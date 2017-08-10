class AddModuleDishesToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :module_dishes, :boolean, default: true
  end
end

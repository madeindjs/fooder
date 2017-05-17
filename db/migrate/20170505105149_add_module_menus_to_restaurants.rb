class AddModuleMenusToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :module_menus, :boolean, default: true
  end
end

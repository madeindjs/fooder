class AddModuleContactToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :module_contact, :boolean, default: true
  end
end

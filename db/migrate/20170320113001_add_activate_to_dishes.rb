class AddActivateToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :activate, :boolean, default: true
    add_column :menus , :activate, :boolean, default: true
  end
end

class AddRootMenuIdToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :root_menu_id, :integer
  end
end

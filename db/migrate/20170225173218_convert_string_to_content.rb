class ConvertStringToContent < ActiveRecord::Migration[5.0]
  def change
    change_column :menus, :description, :text
    change_column :dishes, :description, :text
  end
end

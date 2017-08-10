class ChangePriceTypeForMenus < ActiveRecord::Migration[5.0]
  def change
    change_column :menus, :price, :float
  end
end

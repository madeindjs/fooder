class AddCssToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :css, :string
  end

  def down
    remove_column :restaurants, :css, :string
  end
end

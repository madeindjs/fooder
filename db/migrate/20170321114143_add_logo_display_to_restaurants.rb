class AddLogoDisplayToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :logo_display, :integer, default: 2
  end
end

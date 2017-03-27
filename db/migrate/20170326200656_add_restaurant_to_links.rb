class AddRestaurantToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :restaurant_id, :integer
  end
end

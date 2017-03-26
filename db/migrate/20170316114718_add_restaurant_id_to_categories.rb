class AddRestaurantIdToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :restaurant_id, :integer
  end
end

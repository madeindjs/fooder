class AddPlainOpeningHoursToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :plain_opening_hours, :string
  end
end

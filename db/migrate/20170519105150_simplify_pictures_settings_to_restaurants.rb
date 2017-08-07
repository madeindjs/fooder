class SimplifyPicturesSettingsToRestaurants < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :logo_display, :picture_display

    remove_column :restaurants, :menus_picture_display
    remove_column :restaurants, :dishes_picture_display
    remove_column :restaurants, :posts_picture_display
    remove_column :restaurants, :sections_picture_display
  end
end

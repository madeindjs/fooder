class AddLogoDisplayToOtherModels < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :menus_picture_display,    :integer, default: 2
    add_column :restaurants, :dishes_picture_display,   :integer, default: 2
    add_column :restaurants, :posts_picture_display,    :integer, default: 2
    add_column :restaurants, :sections_picture_display, :integer, default: 2
  end
end

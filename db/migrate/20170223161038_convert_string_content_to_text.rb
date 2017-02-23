class ConvertStringContentToText < ActiveRecord::Migration[5.0]
  def change
    change_column :menus, :content, :text
    change_column :posts, :content, :text
    change_column :sections, :content, :text
  end
end

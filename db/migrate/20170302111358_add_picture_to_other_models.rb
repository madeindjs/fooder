class AddPictureToOtherModels < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :picture, :string
    add_column :posts, :picture, :string
    add_column :sections, :picture, :string
    add_column :users, :picture, :string
    add_column :restaurants, :logo, :string
    add_column :restaurants, :picture, :string
  end

  def rollback
    remove_column :menus, :picture, :string
    remove_column :posts, :picture, :string
    remove_column :sections, :picture, :string
    remove_column :users, :picture, :string
    remove_column :restaurants, :logo, :string
    remove_column :restaurants, :picture, :string
  end
end

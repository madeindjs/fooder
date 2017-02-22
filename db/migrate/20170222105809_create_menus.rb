class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.string :content
      t.string :tags
      t.integer :price
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end

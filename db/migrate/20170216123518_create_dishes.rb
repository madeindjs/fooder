class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.integer :category_id
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end

class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.integer :user_id

      t.timestamps
    end
  end
end

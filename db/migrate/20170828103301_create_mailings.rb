class CreateMailings < ActiveRecord::Migration[5.0]
  def change
    create_table :mailings do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.string :mail
      t.timestamps
    end
  end
end

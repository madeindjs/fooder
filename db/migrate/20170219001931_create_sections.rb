class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end

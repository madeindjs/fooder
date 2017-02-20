class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :tags
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
    add_column :restaurants, :module_blog, :boolean
  end
end

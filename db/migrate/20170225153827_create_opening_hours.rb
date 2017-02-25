class CreateOpeningHours < ActiveRecord::Migration[5.0]
  def change
    create_table :opening_hours do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :day
      t.time :closes
      t.time :opens
      t.datetime :valid_from
      t.datetime :valid_through
      t.timestamps
    end
  end
end

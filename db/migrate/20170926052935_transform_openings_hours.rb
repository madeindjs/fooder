class TransformOpeningsHours < ActiveRecord::Migration[5.0]
  def change
	OpeningHour.delete_all

  	# remove old columns
	remove_column :opening_hours, :user_id
	remove_column :opening_hours, :day
	remove_column :opening_hours, :closes
	remove_column :opening_hours, :opens
	remove_column :opening_hours, :valid_from
	remove_column :opening_hours, :valid_through

	add_column :opening_hours, :monday, :string
	add_column :opening_hours, :tuesday, :string
	add_column :opening_hours, :wednesday, :string
	add_column :opening_hours, :thursday, :string
	add_column :opening_hours, :friday, :string
	add_column :opening_hours, :saturday, :string
	add_column :opening_hours, :sunday, :string
  end
end

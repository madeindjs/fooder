class RemoveUnusedStuffs < ActiveRecord::Migration[5.0]
  def change
    remove_column :links, :logo
    remove_column :links, :order
    remove_column :restaurants, :plain_opening_hours
  end
end

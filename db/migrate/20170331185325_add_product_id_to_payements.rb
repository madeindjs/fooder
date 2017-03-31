class AddProductIdToPayements < ActiveRecord::Migration[5.0]
  def change
    add_column :payements, :product_id, :integer
    remove_column :payements, :months
  end
end

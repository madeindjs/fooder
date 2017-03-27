class AddOrderToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :order, :integer
  end
end

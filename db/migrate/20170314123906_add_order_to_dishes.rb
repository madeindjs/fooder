class AddOrderToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :order, :integer
  end
end

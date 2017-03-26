class AddOrderToSections < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :order, :integer
  end
end

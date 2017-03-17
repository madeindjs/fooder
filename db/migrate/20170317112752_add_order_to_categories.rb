class AddOrderToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :order, :integer
  end
end

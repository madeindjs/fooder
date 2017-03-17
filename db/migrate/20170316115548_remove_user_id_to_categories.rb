class RemoveUserIdToCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :user_id
  end
end

class AddTagsToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :tags, :string
  end
end

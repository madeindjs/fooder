class AddPictureToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :picture, :string
  end
end

class AddDefaultValueToModuleBlog < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :module_blog, :boolean, :default => false
  end
end

class AddInfoToNewsletters < ActiveRecord::Migration[5.0]
  def change
    add_column :newsletters, :firstname, :string
    add_column :newsletters, :lastname, :string
    add_column :newsletters, :website, :string
  end
end

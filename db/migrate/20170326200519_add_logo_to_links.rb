class AddLogoToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :logo, :string
  end
end

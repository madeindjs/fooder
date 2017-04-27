class AddEmailToNewsletter < ActiveRecord::Migration[5.0]
  def change
    add_column :newsletters, :email, :string
  end
end

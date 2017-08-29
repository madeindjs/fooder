class AddEmailToMailings < ActiveRecord::Migration[5.0]
  def change
    add_column :mailings, :email, :string
  end
end

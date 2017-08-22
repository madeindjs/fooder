class AddInformationsToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :phone, :string
    add_column :restaurants, :email, :string
  end
end

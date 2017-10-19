class AddDefaultFieldsToRestaurant < ActiveRecord::Migration[5.0]
  def change
    change_column_default :restaurants, :address, '1 rue de la République'
    change_column_default :restaurants, :zip_code, '69001'
    change_column_default :restaurants, :city, 'Lyon'
  end
end

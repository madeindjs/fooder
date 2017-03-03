class AddAllergensToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :gluten_free, :integer, default: 0
    add_column :dishes, :crustacea_free, :integer, default: 0
    add_column :dishes, :egg_free, :integer, default: 0
    add_column :dishes, :fish_free, :integer, default: 0
    add_column :dishes, :peanut_free, :integer, default: 0
    add_column :dishes, :lactose_free, :integer, default: 0
    add_column :dishes, :nut_free, :integer, default: 0
    add_column :dishes, :sulphite_free, :integer, default: 0
  end

  def rollback
    remove_column :dishes, :gluten_free
    remove_column :dishes, :crustacea_free
    remove_column :dishes, :egg_free
    remove_column :dishes, :fish_free
    remove_column :dishes, :peanut_free
    remove_column :dishes, :lactose_free
    remove_column :dishes, :nut_free
    remove_column :dishes, :sulphite_free
  end
end
